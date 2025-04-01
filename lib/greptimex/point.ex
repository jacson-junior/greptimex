defmodule Greptimex.Point do
  alias Greptimex.ColumnUtils

  defstruct tags: nil, fields: nil, timestamp: nil

  def new(props) do
    %__MODULE__{
      tags: Map.get(props, :tags, %{}),
      fields: Map.get(props, :fields, %{}),
      timestamp: Map.get(props, :timestamp, System.os_time(:millisecond))
    }
  end

  @doc """
  Convert a list of points to GreptimeDB columns

  Args:
    - points: List of Point structs
    - timestamp_column: Name of the timestamp column (default: "timestamp")
    - timestamp_type: Data type for the timestamp (default: :TIMESTAMP_MILLISECOND)

  Returns:
    - List of Greptime.V1.Column structs ready for insertion
  """
  def to_columns(
        points,
        timestamp_column \\ "timestamp",
        timestamp_type \\ :TIMESTAMP_MILLISECOND
      ) do
    if Enum.empty?(points) do
      []
    else
      first_point = List.first(points)
      field_names = Map.keys(first_point.fields)
      tag_names = Map.keys(first_point.tags || %{})

      field_columns =
        Enum.map(field_names, fn field_name ->
          values =
            Enum.map(points, fn point ->
              Map.get(point.fields, field_name)
            end)

          ColumnUtils.prepare_column(field_name, values, :FLOAT64, :FIELD)
        end)

      tag_columns =
        Enum.map(tag_names, fn tag_name ->
          values =
            Enum.map(points, fn point ->
              Map.get(point.tags, tag_name, "")
            end)

          ColumnUtils.prepare_column(tag_name, values, :STRING, :TAG)
        end)

      timestamp_values = Enum.map(points, fn point -> point.timestamp end)

      timestamp_column =
        ColumnUtils.prepare_column(
          timestamp_column,
          timestamp_values,
          timestamp_type,
          :TIMESTAMP
        )

      # Combine all columns
      field_columns ++ tag_columns ++ [timestamp_column]
    end
  end
end
