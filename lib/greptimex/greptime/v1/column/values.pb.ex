defmodule Greptimex.Greptime.V1.Column.Values do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :i8_values, 1, repeated: true, type: :int32, json_name: "i8Values"
  field :i16_values, 2, repeated: true, type: :int32, json_name: "i16Values"
  field :i32_values, 3, repeated: true, type: :int32, json_name: "i32Values"
  field :i64_values, 4, repeated: true, type: :int64, json_name: "i64Values"
  field :u8_values, 5, repeated: true, type: :uint32, json_name: "u8Values"
  field :u16_values, 6, repeated: true, type: :uint32, json_name: "u16Values"
  field :u32_values, 7, repeated: true, type: :uint32, json_name: "u32Values"
  field :u64_values, 8, repeated: true, type: :uint64, json_name: "u64Values"
  field :f32_values, 9, repeated: true, type: :float, json_name: "f32Values"
  field :f64_values, 10, repeated: true, type: :double, json_name: "f64Values"
  field :bool_values, 11, repeated: true, type: :bool, json_name: "boolValues"
  field :binary_values, 12, repeated: true, type: :bytes, json_name: "binaryValues"
  field :string_values, 13, repeated: true, type: :string, json_name: "stringValues"
  field :date_values, 14, repeated: true, type: :int32, json_name: "dateValues"
  field :datetime_values, 15, repeated: true, type: :int64, json_name: "datetimeValues"

  field :timestamp_second_values, 16,
    repeated: true,
    type: :int64,
    json_name: "timestampSecondValues"

  field :timestamp_millisecond_values, 17,
    repeated: true,
    type: :int64,
    json_name: "timestampMillisecondValues"

  field :timestamp_microsecond_values, 18,
    repeated: true,
    type: :int64,
    json_name: "timestampMicrosecondValues"

  field :timestamp_nanosecond_values, 19,
    repeated: true,
    type: :int64,
    json_name: "timestampNanosecondValues"

  field :time_second_values, 20, repeated: true, type: :int64, json_name: "timeSecondValues"

  field :time_millisecond_values, 21,
    repeated: true,
    type: :int64,
    json_name: "timeMillisecondValues"

  field :time_microsecond_values, 22,
    repeated: true,
    type: :int64,
    json_name: "timeMicrosecondValues"

  field :time_nanosecond_values, 23,
    repeated: true,
    type: :int64,
    json_name: "timeNanosecondValues"

  field :interval_year_month_values, 24,
    repeated: true,
    type: :int32,
    json_name: "intervalYearMonthValues"

  field :interval_day_time_values, 25,
    repeated: true,
    type: :int64,
    json_name: "intervalDayTimeValues"

  field :interval_month_day_nano_values, 26,
    repeated: true,
    type: Greptimex.Greptime.V1.IntervalMonthDayNano,
    json_name: "intervalMonthDayNanoValues"

  field :decimal128_values, 31,
    repeated: true,
    type: Greptimex.Greptime.V1.Decimal128,
    json_name: "decimal128Values"

  field :list_values, 40,
    repeated: true,
    type: Greptimex.Greptime.V1.ListValue,
    json_name: "listValues"

  field :struct_values, 41,
    repeated: true,
    type: Greptimex.Greptime.V1.StructValue,
    json_name: "structValues"

  field :json_values, 42,
    repeated: true,
    type: Greptimex.Greptime.V1.Column.Values,
    json_name: "jsonValues"
end
