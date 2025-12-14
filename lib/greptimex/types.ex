defmodule Greptimex.Types do
  @moduledoc """
  Type inference and conversion utilities for GreptimeDB data types.
  """

  alias Greptimex.Greptime.V1

  @doc """
  Infers the datatype of a single value.
  """
  def infer_datatype(value) when is_integer(value), do: :INT64
  def infer_datatype(value) when is_float(value), do: :FLOAT64
  def infer_datatype(value) when is_boolean(value), do: :BOOLEAN
  def infer_datatype(value) when is_binary(value), do: :STRING
  def infer_datatype(%Date{}), do: :DATE
  def infer_datatype(%DateTime{}), do: :DATETIME
  def infer_datatype(%Time{}), do: :TIME_MICROSECOND

  if Code.ensure_loaded?(Decimal) do
    def infer_datatype(%Decimal{}), do: :DECIMAL128
  end

  def infer_datatype(value) when is_map(value), do: :JSON
  def infer_datatype(value) when is_list(value), do: :LIST
  def infer_datatype(_), do: :STRING

  @doc """
  Infers the widest datatype from a list of values.
  Handles both raw values and {value, explicit_datatype} tuples.
  """
  def infer_widest_datatype(values) do
    values
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn
      {_value, explicit_datatype} -> explicit_datatype
      value -> infer_datatype(value)
    end)
    |> Enum.reduce(:STRING, &widen_datatype/2)
  end

  @doc """
  Widens two datatypes to the most general type that can hold both.
  """
  def widen_datatype(dt1, dt2) when dt1 == dt2, do: dt1
  def widen_datatype(:FLOAT64, _), do: :FLOAT64
  def widen_datatype(_, :FLOAT64), do: :FLOAT64
  def widen_datatype(:FLOAT32, dt) when dt in [:INT64, :INT32, :INT16, :INT8], do: :FLOAT64
  def widen_datatype(dt, :FLOAT32) when dt in [:INT64, :INT32, :INT16, :INT8], do: :FLOAT64
  def widen_datatype(:FLOAT32, _), do: :FLOAT32
  def widen_datatype(_, :FLOAT32), do: :FLOAT32
  def widen_datatype(:INT64, dt) when dt in [:INT32, :INT16, :INT8], do: :INT64
  def widen_datatype(dt, :INT64) when dt in [:INT32, :INT16, :INT8], do: :INT64
  def widen_datatype(:INT64, _), do: :INT64
  def widen_datatype(_, :INT64), do: :INT64
  def widen_datatype(:INT32, dt) when dt in [:INT16, :INT8], do: :INT32
  def widen_datatype(dt, :INT32) when dt in [:INT16, :INT8], do: :INT32
  def widen_datatype(:INT16, :INT8), do: :INT16
  def widen_datatype(:INT8, :INT16), do: :INT16
  def widen_datatype(:UINT64, dt) when dt in [:UINT32, :UINT16, :UINT8], do: :UINT64
  def widen_datatype(dt, :UINT64) when dt in [:UINT32, :UINT16, :UINT8], do: :UINT64
  def widen_datatype(:UINT32, dt) when dt in [:UINT16, :UINT8], do: :UINT32
  def widen_datatype(dt, :UINT32) when dt in [:UINT16, :UINT8], do: :UINT32
  def widen_datatype(:UINT16, :UINT8), do: :UINT16
  def widen_datatype(:UINT8, :UINT16), do: :UINT16

  def widen_datatype(:TIME_NANOSECOND, dt)
      when dt in [:TIME_MICROSECOND, :TIME_MILLISECOND, :TIME_SECOND],
      do: :TIME_NANOSECOND

  def widen_datatype(dt, :TIME_NANOSECOND)
      when dt in [:TIME_MICROSECOND, :TIME_MILLISECOND, :TIME_SECOND],
      do: :TIME_NANOSECOND

  def widen_datatype(:TIME_MICROSECOND, dt) when dt in [:TIME_MILLISECOND, :TIME_SECOND],
    do: :TIME_MICROSECOND

  def widen_datatype(dt, :TIME_MICROSECOND) when dt in [:TIME_MILLISECOND, :TIME_SECOND],
    do: :TIME_MICROSECOND

  def widen_datatype(:TIME_MILLISECOND, :TIME_SECOND), do: :TIME_MILLISECOND
  def widen_datatype(:TIME_SECOND, :TIME_MILLISECOND), do: :TIME_MILLISECOND
  def widen_datatype(_, _), do: :STRING

  @doc """
  Converts a timestamp value to a GreptimeDB Value based on datatype.
  """
  def timestamp_value(:TIMESTAMP_NANOSECOND, ts),
    do: %V1.Value{value_data: {:timestamp_nanosecond_value, ts}}

  def timestamp_value(:TIMESTAMP_MICROSECOND, ts),
    do: %V1.Value{value_data: {:timestamp_microsecond_value, ts}}

  def timestamp_value(:TIMESTAMP_MILLISECOND, ts),
    do: %V1.Value{value_data: {:timestamp_millisecond_value, ts}}

  def timestamp_value(:TIMESTAMP_SECOND, ts),
    do: %V1.Value{value_data: {:timestamp_second_value, ts}}

  def timestamp_value(_, ts), do: %V1.Value{value_data: {:timestamp_millisecond_value, ts}}

  @doc """
  Converts a field value to a GreptimeDB Value based on datatype.
  """
  def field_value(:INT8, v), do: %V1.Value{value_data: {:i8_value, v}}
  def field_value(:INT16, v), do: %V1.Value{value_data: {:i16_value, v}}
  def field_value(:INT32, v), do: %V1.Value{value_data: {:i32_value, v}}
  def field_value(:INT64, v), do: %V1.Value{value_data: {:i64_value, v}}
  def field_value(:UINT8, v), do: %V1.Value{value_data: {:u8_value, v}}
  def field_value(:UINT16, v), do: %V1.Value{value_data: {:u16_value, v}}
  def field_value(:UINT32, v), do: %V1.Value{value_data: {:u32_value, v}}
  def field_value(:UINT64, v), do: %V1.Value{value_data: {:u64_value, v}}
  def field_value(:FLOAT32, v), do: %V1.Value{value_data: {:f32_value, v * 1.0}}
  def field_value(:FLOAT64, v), do: %V1.Value{value_data: {:f64_value, v * 1.0}}
  def field_value(:BOOLEAN, v), do: %V1.Value{value_data: {:bool_value, v}}
  def field_value(:STRING, v), do: %V1.Value{value_data: {:string_value, to_string(v)}}
  def field_value(:BINARY, v), do: %V1.Value{value_data: {:binary_value, v}}

  def field_value(:DATE, %Date{} = v) do
    days = Date.diff(v, ~D[1970-01-01])
    %V1.Value{value_data: {:date_value, days}}
  end

  def field_value(:DATE, v) when is_integer(v) do
    %V1.Value{value_data: {:date_value, v}}
  end

  def field_value(:DATETIME, %DateTime{} = v) do
    millis = DateTime.to_unix(v, :millisecond)
    %V1.Value{value_data: {:datetime_value, millis}}
  end

  def field_value(:DATETIME, v) when is_integer(v) do
    %V1.Value{value_data: {:datetime_value, v}}
  end

  def field_value(:TIME_SECOND, v), do: %V1.Value{value_data: {:time_second_value, v}}
  def field_value(:TIME_MILLISECOND, v), do: %V1.Value{value_data: {:time_millisecond_value, v}}
  def field_value(:TIME_MICROSECOND, v), do: %V1.Value{value_data: {:time_microsecond_value, v}}
  def field_value(:TIME_NANOSECOND, v), do: %V1.Value{value_data: {:time_nanosecond_value, v}}

  def field_value(:INTERVAL_YEAR_MONTH, v),
    do: %V1.Value{value_data: {:interval_year_month_value, v}}

  def field_value(:INTERVAL_DAY_TIME, v),
    do: %V1.Value{value_data: {:interval_day_time_value, v}}

  def field_value(:INTERVAL_MONTH_DAY_NANO, %{months: m, days: d, nanoseconds: n}) do
    %V1.Value{
      value_data:
        {:interval_month_day_nano_value,
         %V1.IntervalMonthDayNano{months: m, days: d, nanoseconds: n}}
    }
  end

  if Code.ensure_loaded?(Decimal) do
    def field_value(:DECIMAL128, %Decimal{} = v) do
      {hi, lo} = decimal_to_int128(v)
      %V1.Value{value_data: {:decimal128_value, %V1.Decimal128{hi: hi, lo: lo}}}
    end

    # Helper to convert Decimal to int128 (hi/lo representation)
    defp decimal_to_int128(%Decimal{} = d) do
      # Simple implementation - convert to integer representation
      # This is a simplified version; you may need more sophisticated handling
      int_val = Decimal.to_integer(Decimal.mult(d, Decimal.new(1_000_000)))
      hi = div(int_val, 0x10000000000000000)
      lo = rem(int_val, 0x10000000000000000)
      {hi, lo}
    end
  end

  def field_value(:JSON, v) when is_map(v) or is_list(v) do
    json_str = JSON.encode!(v)
    %V1.Value{value_data: {:string_value, json_str}}
  end

  def field_value(:LIST, values) when is_list(values) do
    list_values =
      Enum.map(values, fn v ->
        cond do
          is_integer(v) -> %V1.Value{value_data: {:i64_value, v}}
          is_float(v) -> %V1.Value{value_data: {:f64_value, v}}
          is_binary(v) -> %V1.Value{value_data: {:string_value, v}}
          is_boolean(v) -> %V1.Value{value_data: {:bool_value, v}}
          true -> %V1.Value{value_data: {:string_value, to_string(v)}}
        end
      end)

    %V1.Value{value_data: {:list_value, %V1.ListValue{items: list_values}}}
  end

  def field_value(_, v) when is_float(v), do: %V1.Value{value_data: {:f64_value, v}}
  def field_value(_, v) when is_integer(v), do: %V1.Value{value_data: {:i64_value, v}}
  def field_value(_, v), do: %V1.Value{value_data: {:f64_value, v * 1.0}}

  @doc """
  Converts a tag value to a GreptimeDB Value based on datatype.
  """
  def tag_value(:STRING, v), do: %V1.Value{value_data: {:string_value, to_string(v)}}
  def tag_value(:INT8, v), do: %V1.Value{value_data: {:i8_value, v}}
  def tag_value(:INT16, v), do: %V1.Value{value_data: {:i16_value, v}}
  def tag_value(:INT32, v), do: %V1.Value{value_data: {:i32_value, v}}
  def tag_value(:INT64, v), do: %V1.Value{value_data: {:i64_value, v}}
  def tag_value(:UINT8, v), do: %V1.Value{value_data: {:u8_value, v}}
  def tag_value(:UINT16, v), do: %V1.Value{value_data: {:u16_value, v}}
  def tag_value(:UINT32, v), do: %V1.Value{value_data: {:u32_value, v}}
  def tag_value(:UINT64, v), do: %V1.Value{value_data: {:u64_value, v}}
  def tag_value(:BINARY, v), do: %V1.Value{value_data: {:binary_value, v}}
  def tag_value(_, v), do: %V1.Value{value_data: {:string_value, to_string(v)}}

  @doc """
  Extracts the raw value from either a plain value or {value, datatype} tuple.
  Returns {value, datatype} or {value, nil}.
  """
  def extract_value({value, datatype}) when is_atom(datatype), do: {value, datatype}
  def extract_value(value), do: value

  @doc """
  Normalizes a value to {raw_value, explicit_datatype | nil} tuple.
  """
  def normalize_value({value, datatype}) when is_atom(datatype), do: {value, datatype}
  def normalize_value(value), do: {value, nil}
end
