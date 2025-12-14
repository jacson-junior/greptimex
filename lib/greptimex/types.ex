defmodule Greptimex.Types do
  @moduledoc false

  alias Greptimex.Greptime.V1

  def infer_datatype(value) when is_integer(value), do: :INT64
  def infer_datatype(value) when is_float(value), do: :FLOAT64
  def infer_datatype(value) when is_boolean(value), do: :BOOLEAN
  def infer_datatype(value) when is_binary(value), do: :STRING
  def infer_datatype(%Date{}), do: :DATE
  def infer_datatype(%DateTime{}), do: :DATETIME
  def infer_datatype(%Time{}), do: :TIME_MICROSECOND
  def infer_datatype(%NaiveDateTime{}), do: :DATETIME

  if Code.ensure_loaded?(Decimal) do
    def infer_datatype(%Decimal{}), do: :DECIMAL128
  end

  def infer_datatype(value) when is_map(value), do: :JSON
  def infer_datatype(value) when is_list(value), do: :LIST
  def infer_datatype(_), do: :STRING

  def infer_widest_datatype(values) do
    values
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn
      {_value, explicit_datatype} -> explicit_datatype
      value -> infer_datatype(value)
    end)
    |> Enum.reduce(:STRING, &widen_datatype/2)
  end

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

  def timestamp_value(:TIMESTAMP_NANOSECOND, %DateTime{} = ts) do
    nanos = DateTime.to_unix(ts, :nanosecond)
    %V1.Value{value_data: {:timestamp_nanosecond_value, nanos}}
  end

  def timestamp_value(:TIMESTAMP_NANOSECOND, ts) when is_integer(ts),
    do: %V1.Value{value_data: {:timestamp_nanosecond_value, ts}}

  def timestamp_value(:TIMESTAMP_MICROSECOND, %DateTime{} = ts) do
    micros = DateTime.to_unix(ts, :microsecond)
    %V1.Value{value_data: {:timestamp_microsecond_value, micros}}
  end

  def timestamp_value(:TIMESTAMP_MICROSECOND, ts) when is_integer(ts),
    do: %V1.Value{value_data: {:timestamp_microsecond_value, ts}}

  def timestamp_value(:TIMESTAMP_MILLISECOND, %DateTime{} = ts) do
    millis = DateTime.to_unix(ts, :millisecond)
    %V1.Value{value_data: {:timestamp_millisecond_value, millis}}
  end

  def timestamp_value(:TIMESTAMP_MILLISECOND, ts) when is_integer(ts),
    do: %V1.Value{value_data: {:timestamp_millisecond_value, ts}}

  def timestamp_value(:TIMESTAMP_SECOND, %DateTime{} = ts) do
    seconds = DateTime.to_unix(ts, :second)
    %V1.Value{value_data: {:timestamp_second_value, seconds}}
  end

  def timestamp_value(:TIMESTAMP_SECOND, ts) when is_integer(ts),
    do: %V1.Value{value_data: {:timestamp_second_value, ts}}

  def timestamp_value(_, %DateTime{} = ts) do
    millis = DateTime.to_unix(ts, :millisecond)
    %V1.Value{value_data: {:timestamp_millisecond_value, millis}}
  end

  def timestamp_value(_, ts) when is_integer(ts),
    do: %V1.Value{value_data: {:timestamp_millisecond_value, ts}}

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

  def field_value(:DATETIME, %NaiveDateTime{} = v) do
    # Convert NaiveDateTime to milliseconds since epoch (assuming UTC)
    millis = NaiveDateTime.diff(v, ~N[1970-01-01 00:00:00], :millisecond)
    %V1.Value{value_data: {:datetime_value, millis}}
  end

  def field_value(:DATETIME, v) when is_integer(v) do
    %V1.Value{value_data: {:datetime_value, v}}
  end

  def field_value(:TIME_SECOND, %Time{} = v) do
    seconds = v.hour * 3600 + v.minute * 60 + v.second
    %V1.Value{value_data: {:time_second_value, seconds}}
  end

  def field_value(:TIME_SECOND, v) when is_integer(v),
    do: %V1.Value{value_data: {:time_second_value, v}}

  def field_value(:TIME_MILLISECOND, %Time{} = v) do
    millis =
      (v.hour * 3600 + v.minute * 60 + v.second) * 1000 + div(v.microsecond |> elem(0), 1000)

    %V1.Value{value_data: {:time_millisecond_value, millis}}
  end

  def field_value(:TIME_MILLISECOND, v) when is_integer(v),
    do: %V1.Value{value_data: {:time_millisecond_value, v}}

  def field_value(:TIME_MICROSECOND, %Time{} = v) do
    micros = (v.hour * 3600 + v.minute * 60 + v.second) * 1_000_000 + (v.microsecond |> elem(0))
    %V1.Value{value_data: {:time_microsecond_value, micros}}
  end

  def field_value(:TIME_MICROSECOND, v) when is_integer(v),
    do: %V1.Value{value_data: {:time_microsecond_value, v}}

  def field_value(:TIME_NANOSECOND, %Time{} = v) do
    {micros, _precision} = v.microsecond
    nanos = (v.hour * 3600 + v.minute * 60 + v.second) * 1_000_000_000 + micros * 1000
    %V1.Value{value_data: {:time_nanosecond_value, nanos}}
  end

  def field_value(:TIME_NANOSECOND, v) when is_integer(v),
    do: %V1.Value{value_data: {:time_nanosecond_value, v}}

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

  def extract_value({value, datatype}) when is_atom(datatype), do: {value, datatype}
  def extract_value(value), do: value

  def normalize_value({value, datatype}) when is_atom(datatype), do: {value, datatype}
  def normalize_value(value), do: {value, nil}
end
