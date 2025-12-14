defmodule Greptimex.Insert do
  @moduledoc false

  alias Greptimex.Connection
  alias Greptimex.Greptime.V1
  alias Greptimex.Types

  def handle(channel, rows, opts) when is_list(rows) do
    {table, row_count} = extract_table_info(rows)
    start_time = System.monotonic_time()
    metadata = %{table: table, row_count: row_count}

    emit_start(metadata)

    inserts = Enum.map(rows, fn row -> row_to_insert(row, opts[:defaults]) end)

    result =
      V1.GreptimeDatabase.Stub.handle(
        channel,
        %V1.GreptimeRequest{
          header: Connection.header(opts[:header]),
          request: {:row_inserts, %V1.RowInsertRequests{inserts: inserts}}
        }
      )

    duration = System.monotonic_time() - start_time

    case result do
      {:ok,
       %{
         header: %{status: %{status_code: 0}},
         response: {:affected_rows, %{value: affected_rows}}
       }} ->
        emit_success(duration, affected_rows, metadata)
        {:ok, affected_rows}

      {:ok, %{header: %{status: %{status_code: status, err_msg: message}}}} ->
        error = %{status: status, message: message}
        emit_failure(duration, :error, error, metadata)
        {:error, error}

      {:error, reason} ->
        emit_failure(duration, :error, reason, metadata)
        {:error, reason}
    end
  end

  defp extract_table_info(rows) do
    table =
      case List.first(rows) do
        {table_name, _} -> table_name
        _ -> nil
      end

    row_count =
      Enum.reduce(rows, 0, fn
        {_, rows_list}, acc when is_list(rows_list) -> acc + length(rows_list)
        {_, _row}, acc -> acc + 1
        _, acc -> acc
      end)

    {table, row_count}
  end

  defp row_to_insert({table, rows}, opts) when is_list(rows) do
    schema = create_schema(rows, opts)
    index_map = index_schema(schema)

    row_data =
      Enum.map(rows, fn %{tags: tags, fields: fields, timestamp: timestamp} ->
        point_to_row(tags, fields, timestamp, index_map, opts)
      end)

    %V1.RowInsertRequest{
      table_name: to_string(table),
      rows: %V1.Rows{
        schema: schema,
        rows: row_data
      }
    }
  end

  defp row_to_insert({table, %{tags: _, fields: _, timestamp: _} = row}, opts) do
    row_to_insert({table, [row]}, opts)
  end

  defp create_schema(rows, opts) do
    timestamp_schema = %V1.ColumnSchema{
      column_name: to_string(opts[:timestamp_name]),
      datatype: opts[:timestamp_datatype],
      semantic_type: :TIMESTAMP
    }

    # Collect all tags and fields across all rows
    all_tags = Enum.flat_map(rows, fn %{tags: tags} -> tags end)
    all_fields = Enum.flat_map(rows, fn %{fields: fields} -> fields end)

    # Group by column name and infer widest datatype
    tag_schemas =
      all_tags
      |> Enum.group_by(fn {name, _} -> to_string(name) end, fn {_, value} ->
        Types.extract_value(value)
      end)
      |> Enum.map(fn {name, values} ->
        %V1.ColumnSchema{
          column_name: name,
          datatype: Types.infer_widest_datatype(values),
          semantic_type: :TAG
        }
      end)
      |> Enum.sort_by(& &1.column_name)

    field_schemas =
      all_fields
      |> Enum.group_by(fn {name, _} -> to_string(name) end, fn {_, value} ->
        Types.extract_value(value)
      end)
      |> Enum.map(fn {name, values} ->
        %V1.ColumnSchema{
          column_name: name,
          datatype: Types.infer_widest_datatype(values),
          semantic_type: :FIELD
        }
      end)
      |> Enum.sort_by(& &1.column_name)

    [timestamp_schema] ++ tag_schemas ++ field_schemas
  end

  defp index_schema(schema) do
    schema
    |> Enum.with_index(1)
    |> Enum.map(fn {%{column_name: name, semantic_type: sem, datatype: dt}, idx} ->
      {name, {idx, sem, dt}}
    end)
    |> Map.new()
  end

  defp point_to_row(tags, fields, timestamp, index_map, opts) do
    n = map_size(index_map)
    values = List.duplicate(%V1.Value{}, n)
    timestamp_name = to_string(opts[:timestamp_name])

    {^timestamp_name, {ts_idx, :TIMESTAMP, ts_dt}} =
      Enum.find(index_map, fn {name, _} -> name == timestamp_name end)

    values = List.replace_at(values, ts_idx - 1, Types.timestamp_value(ts_dt, timestamp))

    values =
      Enum.reduce(tags, values, fn {name, value}, acc ->
        case Map.get(index_map, to_string(name)) do
          {idx, :TAG, dt} ->
            {raw_value, _} = Types.normalize_value(value)
            List.replace_at(acc, idx - 1, Types.tag_value(dt, raw_value))

          _ ->
            acc
        end
      end)

    values =
      Enum.reduce(fields, values, fn {name, value}, acc ->
        case Map.get(index_map, to_string(name)) do
          {idx, :FIELD, dt} ->
            {raw_value, _} = Types.normalize_value(value)
            List.replace_at(acc, idx - 1, Types.field_value(dt, raw_value))

          _ ->
            acc
        end
      end)

    %V1.Row{values: values}
  end

  defp emit_start(metadata) do
    :telemetry.execute(
      [:greptimex, :insert, :start],
      %{system_time: System.system_time()},
      metadata
    )
  end

  defp emit_success(duration, affected_rows, metadata) do
    :telemetry.execute(
      [:greptimex, :insert, :success],
      %{duration: duration, affected_rows: affected_rows},
      metadata
    )
  end

  defp emit_failure(duration, kind, reason, metadata) do
    :telemetry.execute(
      [:greptimex, :insert, :failure],
      %{duration: duration},
      Map.merge(metadata, %{kind: kind, reason: reason})
    )
  end
end
