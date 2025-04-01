defmodule Greptimex.PointTest do
  use ExUnit.Case, async: true
  alias Greptimex.Point

  describe "to_columns/3" do
    test "returns empty list when no points provided" do
      assert Point.to_columns([]) == []
    end

    test "converts a single point to columns" do
      point = %Point{
        tags: %{"host" => "server-1"},
        fields: %{"cpu" => 10.5},
        timestamp: 1000
      }

      columns = Point.to_columns([point])

      assert length(columns) == 3

      cpu_column = Enum.find(columns, fn col -> col.column_name == "cpu" end)
      host_column = Enum.find(columns, fn col -> col.column_name == "host" end)
      timestamp_column = Enum.find(columns, fn col -> col.column_name == "timestamp" end)

      assert cpu_column.semantic_type == :FIELD
      assert cpu_column.datatype == :FLOAT64
      assert cpu_column.values.f64_values == [10.5]

      assert host_column.semantic_type == :TAG
      assert host_column.datatype == :STRING
      assert host_column.values.string_values == ["server-1"]

      assert timestamp_column.semantic_type == :TIMESTAMP
      assert timestamp_column.datatype == :TIMESTAMP_MILLISECOND
      assert timestamp_column.values.timestamp_millisecond_values == [1000]
    end

    test "handles multiple points with same structure" do
      points = [
        %Point{
          tags: %{"host" => "server-1"},
          fields: %{"cpu" => 10.5, "memory" => 50},
          timestamp: 1000
        },
        %Point{
          tags: %{"host" => "server-2"},
          fields: %{"cpu" => 20.5, "memory" => 60},
          timestamp: 2000
        }
      ]

      columns = Point.to_columns(points)

      assert length(columns) == 4

      cpu_column = Enum.find(columns, fn col -> col.column_name == "cpu" end)
      memory_column = Enum.find(columns, fn col -> col.column_name == "memory" end)
      host_column = Enum.find(columns, fn col -> col.column_name == "host" end)
      timestamp_column = Enum.find(columns, fn col -> col.column_name == "timestamp" end)

      assert cpu_column.values.f64_values == [10.5, 20.5]
      assert memory_column.values.i32_values == [50, 60]
      assert host_column.values.string_values == ["server-1", "server-2"]
      assert timestamp_column.values.timestamp_millisecond_values == [1000, 2000]
    end

    test "uses custom timestamp column name when provided" do
      point = %Point{
        fields: %{"value" => 10.5},
        timestamp: 1000
      }

      columns = Point.to_columns([point], "time")

      timestamp_column = Enum.find(columns, fn col -> col.column_name == "time" end)
      assert timestamp_column.semantic_type == :TIMESTAMP
    end

    test "uses custom timestamp type when provided" do
      point = %Point{
        fields: %{"value" => 10.5},
        timestamp: 1000
      }

      columns = Point.to_columns([point], "timestamp", :TIMESTAMP_SECOND)

      timestamp_column = Enum.find(columns, fn col -> col.column_name == "timestamp" end)
      assert timestamp_column.datatype == :TIMESTAMP_SECOND
      assert timestamp_column.values.timestamp_second_values == [1000]
    end

    test "handles null tags map" do
      point = %Point{
        tags: nil,
        fields: %{"value" => 10.5},
        timestamp: 1000
      }

      columns = Point.to_columns([point])

      # Should only have field and timestamp columns (no tag columns)
      assert length(columns) == 2
      assert Enum.any?(columns, fn col -> col.column_name == "value" end)
      assert Enum.any?(columns, fn col -> col.column_name == "timestamp" end)
    end
  end
end
