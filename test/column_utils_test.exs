defmodule Greptimex.ColumnUtilsTest do
  use ExUnit.Case, async: true
  alias Greptimex.ColumnUtils

  describe "determine_data_type/1" do
    test "determines INT32 for small integers" do
      assert ColumnUtils.determine_data_type([1, 2, 3]) == :INT32
      assert ColumnUtils.determine_data_type([0, -100, 2_000_000]) == :INT32
    end

    test "determines INT64 for large integers" do
      assert ColumnUtils.determine_data_type([2_147_483_648]) == :INT64
      assert ColumnUtils.determine_data_type([-2_147_483_649]) == :INT64
    end

    test "determines FLOAT64 for floats" do
      assert ColumnUtils.determine_data_type([1.0, 2.5]) == :FLOAT64
    end

    test "determines STRING for binaries" do
      assert ColumnUtils.determine_data_type(["test", "hello"]) == :STRING
    end

    test "determines BOOLEAN for booleans" do
      assert ColumnUtils.determine_data_type([true, false]) == :BOOLEAN
    end

    test "defaults to FLOAT64 for unknown types" do
      assert ColumnUtils.determine_data_type([%{}]) == :FLOAT64
    end

    test "handles nil values by finding first non-nil value" do
      assert ColumnUtils.determine_data_type([nil, 1, 2]) == :INT32
      assert ColumnUtils.determine_data_type([nil, "test"]) == :STRING
    end

    test "defaults to FLOAT64 when all values are nil" do
      assert ColumnUtils.determine_data_type([nil, nil]) == :FLOAT64
    end
  end

  describe "get_values_field/2" do
    test "creates appropriate Values struct for INT types" do
      assert ColumnUtils.get_values_field(:INT8, [1, 2, 3]) == %Greptime.V1.Column.Values{
               i8_values: [1, 2, 3]
             }

      assert ColumnUtils.get_values_field(:INT16, [1, 2, 3]) == %Greptime.V1.Column.Values{
               i16_values: [1, 2, 3]
             }

      assert ColumnUtils.get_values_field(:INT32, [1, 2, 3]) == %Greptime.V1.Column.Values{
               i32_values: [1, 2, 3]
             }

      assert ColumnUtils.get_values_field(:INT64, [1, 2, 3]) == %Greptime.V1.Column.Values{
               i64_values: [1, 2, 3]
             }
    end

    test "creates appropriate Values struct for UINT types" do
      assert ColumnUtils.get_values_field(:UINT8, [1, 2, 3]) == %Greptime.V1.Column.Values{
               u8_values: [1, 2, 3]
             }

      assert ColumnUtils.get_values_field(:UINT16, [1, 2, 3]) == %Greptime.V1.Column.Values{
               u16_values: [1, 2, 3]
             }

      assert ColumnUtils.get_values_field(:UINT32, [1, 2, 3]) == %Greptime.V1.Column.Values{
               u32_values: [1, 2, 3]
             }

      assert ColumnUtils.get_values_field(:UINT64, [1, 2, 3]) == %Greptime.V1.Column.Values{
               u64_values: [1, 2, 3]
             }
    end

    test "creates appropriate Values struct for floating point types" do
      assert ColumnUtils.get_values_field(:FLOAT32, [1.0, 2.0]) == %Greptime.V1.Column.Values{
               f32_values: [1.0, 2.0]
             }

      assert ColumnUtils.get_values_field(:FLOAT64, [1.0, 2.0]) == %Greptime.V1.Column.Values{
               f64_values: [1.0, 2.0]
             }
    end

    test "creates appropriate Values struct for boolean type" do
      assert ColumnUtils.get_values_field(:BOOLEAN, [true, false]) == %Greptime.V1.Column.Values{
               bool_values: [true, false]
             }
    end

    test "creates appropriate Values struct for string type" do
      assert ColumnUtils.get_values_field(:STRING, ["a", "b"]) == %Greptime.V1.Column.Values{
               string_values: ["a", "b"]
             }
    end

    test "creates appropriate Values struct for binary type" do
      assert ColumnUtils.get_values_field(:BINARY, ["a", "b"]) == %Greptime.V1.Column.Values{
               binary_values: ["a", "b"]
             }
    end

    test "creates appropriate Values struct for timestamp types" do
      assert ColumnUtils.get_values_field(:TIMESTAMP_MILLISECOND, [1, 2]) ==
               %Greptime.V1.Column.Values{timestamp_millisecond_values: [1, 2]}

      assert ColumnUtils.get_values_field(:TIMESTAMP_SECOND, [1, 2]) ==
               %Greptime.V1.Column.Values{timestamp_second_values: [1, 2]}

      assert ColumnUtils.get_values_field(:TIMESTAMP_MICROSECOND, [1, 2]) ==
               %Greptime.V1.Column.Values{timestamp_microsecond_values: [1, 2]}

      assert ColumnUtils.get_values_field(:TIMESTAMP_NANOSECOND, [1, 2]) ==
               %Greptime.V1.Column.Values{timestamp_nanosecond_values: [1, 2]}
    end

    test "raises error for unsupported data type" do
      assert_raise RuntimeError, "Unsupported data type: UNKNOWN", fn ->
        ColumnUtils.get_values_field(:UNKNOWN, [1, 2, 3])
      end
    end
  end

  describe "semantic_type_to_enum/1" do
    test "converts semantic types to GreptimeDB enums" do
      assert ColumnUtils.semantic_type_to_enum(:TAG) == :TAG
      assert ColumnUtils.semantic_type_to_enum(:FIELD) == :FIELD
      assert ColumnUtils.semantic_type_to_enum(:TIMESTAMP) == :TIMESTAMP
    end

    test "raises error for unsupported semantic type" do
      assert_raise RuntimeError, "Unsupported semantic type: UNKNOWN", fn ->
        ColumnUtils.semantic_type_to_enum(:UNKNOWN)
      end
    end
  end

  describe "convert_timestamp_values/2" do
    test "converts milliseconds to seconds" do
      assert ColumnUtils.convert_timestamp_values([1000, 2000, 3000], :TIMESTAMP_SECOND) == [
               1,
               2,
               3
             ]
    end

    test "keeps milliseconds as is" do
      assert ColumnUtils.convert_timestamp_values([1000, 2000, 3000], :TIMESTAMP_MILLISECOND) == [
               1000,
               2000,
               3000
             ]
    end

    test "converts milliseconds to microseconds" do
      assert ColumnUtils.convert_timestamp_values([1, 2, 3], :TIMESTAMP_MICROSECOND) == [
               1000,
               2000,
               3000
             ]
    end

    test "converts milliseconds to nanoseconds" do
      assert ColumnUtils.convert_timestamp_values([1, 2, 3], :TIMESTAMP_NANOSECOND) == [
               1_000_000,
               2_000_000,
               3_000_000
             ]
    end

    test "returns original values for unknown timestamp type" do
      assert ColumnUtils.convert_timestamp_values([1, 2, 3], :UNKNOWN) == [1, 2, 3]
    end
  end

  describe "prepare_column/4" do
    test "creates a column struct with correct fields" do
      column = ColumnUtils.prepare_column("test", [1, 2, 3], :INT32, :FIELD)

      assert column.column_name == "test"
      assert column.semantic_type == :FIELD
      assert column.datatype == :INT32
      assert column.values == %Greptime.V1.Column.Values{i32_values: [1, 2, 3]}
    end
  end
end
