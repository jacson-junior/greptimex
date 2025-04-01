defmodule Greptimex.ColumnUtils do
  @moduledoc """
  Utilities for working with GreptimeDB column data
  """

  @doc """
  Determine the data type for a list of values
  """
  def determine_data_type(values) do
    first_value = Enum.find(values, nil, fn v -> v != nil end) |> dbg

    cond do
      is_float(first_value) ->
        :FLOAT64

      is_integer(first_value) ->
        if first_value > 2_147_483_647 or first_value < -2_147_483_648 do
          :INT64
        else
          :INT32
        end

      is_boolean(first_value) ->
        :BOOLEAN

      is_binary(first_value) ->
        :STRING

      true ->
        :FLOAT64
    end
  end

  @doc """
  Create a Column.Values struct for the given data type and values
  """
  def get_values_field(data_type, values) do
    case data_type do
      :INT8 -> %Greptime.V1.Column.Values{i8_values: values}
      :INT16 -> %Greptime.V1.Column.Values{i16_values: values}
      :INT32 -> %Greptime.V1.Column.Values{i32_values: values}
      :INT64 -> %Greptime.V1.Column.Values{i64_values: values}
      :UINT8 -> %Greptime.V1.Column.Values{u8_values: values}
      :UINT16 -> %Greptime.V1.Column.Values{u16_values: values}
      :UINT32 -> %Greptime.V1.Column.Values{u32_values: values}
      :UINT64 -> %Greptime.V1.Column.Values{u64_values: values}
      :FLOAT32 -> %Greptime.V1.Column.Values{f32_values: values}
      :FLOAT64 -> %Greptime.V1.Column.Values{f64_values: values}
      :BOOLEAN -> %Greptime.V1.Column.Values{bool_values: values}
      :STRING -> %Greptime.V1.Column.Values{string_values: values}
      :BINARY -> %Greptime.V1.Column.Values{binary_values: values}
      :TIMESTAMP_MILLISECOND -> %Greptime.V1.Column.Values{timestamp_millisecond_values: values}
      :TIMESTAMP_SECOND -> %Greptime.V1.Column.Values{timestamp_second_values: values}
      :TIMESTAMP_MICROSECOND -> %Greptime.V1.Column.Values{timestamp_microsecond_values: values}
      :TIMESTAMP_NANOSECOND -> %Greptime.V1.Column.Values{timestamp_nanosecond_values: values}
      _ -> raise "Unsupported data type: #{data_type}"
    end
  end

  @doc """
  Convert semantic type atom to GreptimeDB enum
  """
  def semantic_type_to_enum(type) do
    case type do
      :TAG -> :TAG
      :FIELD -> :FIELD
      :TIMESTAMP -> :TIMESTAMP
      _ -> raise "Unsupported semantic type: #{type}"
    end
  end

  @doc """
  Convert timestamp values based on the target timestamp type
  """
  def convert_timestamp_values(values, target_type) do
    case target_type do
      :TIMESTAMP_SECOND ->
        Enum.map(values, fn ms -> div(ms, 1000) end)

      :TIMESTAMP_MILLISECOND ->
        # No conversion needed, already in milliseconds
        values

      :TIMESTAMP_MICROSECOND ->
        # Convert ms to μs
        Enum.map(values, fn ms -> ms * 1000 end)

      :TIMESTAMP_NANOSECOND ->
        # Convert ms to ns
        Enum.map(values, fn ms -> ms * 1_000_000 end)

      _ ->
        # Default to no conversion
        values
    end
  end

  @doc """
  Create a column struct from raw data
  """
  def prepare_column(name, values, data_type, semantic_type) do
    values_field = get_values_field(data_type, values)

    %Greptime.V1.Column{
      column_name: name,
      semantic_type: semantic_type_to_enum(semantic_type),
      datatype: data_type,
      values: values_field
    }
  end
end
