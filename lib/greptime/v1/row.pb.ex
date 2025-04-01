defmodule Greptime.V1.Rows do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :schema, 1, repeated: true, type: Greptime.V1.ColumnSchema
  field :rows, 2, repeated: true, type: Greptime.V1.Row
end

defmodule Greptime.V1.ColumnSchema do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :datatype, 2, type: Greptime.V1.ColumnDataType, enum: true
  field :semantic_type, 3, type: Greptime.V1.SemanticType, json_name: "semanticType", enum: true

  field :datatype_extension, 4,
    type: Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"

  field :options, 5, type: Greptime.V1.ColumnOptions
end

defmodule Greptime.V1.Row do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :values, 1, repeated: true, type: Greptime.V1.Value
end

defmodule Greptime.V1.Value do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :value_data, 0

  field :i8_value, 1, type: :int32, json_name: "i8Value", oneof: 0
  field :i16_value, 2, type: :int32, json_name: "i16Value", oneof: 0
  field :i32_value, 3, type: :int32, json_name: "i32Value", oneof: 0
  field :i64_value, 4, type: :int64, json_name: "i64Value", oneof: 0
  field :u8_value, 5, type: :uint32, json_name: "u8Value", oneof: 0
  field :u16_value, 6, type: :uint32, json_name: "u16Value", oneof: 0
  field :u32_value, 7, type: :uint32, json_name: "u32Value", oneof: 0
  field :u64_value, 8, type: :uint64, json_name: "u64Value", oneof: 0
  field :f32_value, 9, type: :float, json_name: "f32Value", oneof: 0
  field :f64_value, 10, type: :double, json_name: "f64Value", oneof: 0
  field :bool_value, 11, type: :bool, json_name: "boolValue", oneof: 0
  field :binary_value, 12, type: :bytes, json_name: "binaryValue", oneof: 0
  field :string_value, 13, type: :string, json_name: "stringValue", oneof: 0
  field :date_value, 14, type: :int32, json_name: "dateValue", oneof: 0
  field :datetime_value, 15, type: :int64, json_name: "datetimeValue", oneof: 0
  field :timestamp_second_value, 16, type: :int64, json_name: "timestampSecondValue", oneof: 0

  field :timestamp_millisecond_value, 17,
    type: :int64,
    json_name: "timestampMillisecondValue",
    oneof: 0

  field :timestamp_microsecond_value, 18,
    type: :int64,
    json_name: "timestampMicrosecondValue",
    oneof: 0

  field :timestamp_nanosecond_value, 19,
    type: :int64,
    json_name: "timestampNanosecondValue",
    oneof: 0

  field :time_second_value, 20, type: :int64, json_name: "timeSecondValue", oneof: 0
  field :time_millisecond_value, 21, type: :int64, json_name: "timeMillisecondValue", oneof: 0
  field :time_microsecond_value, 22, type: :int64, json_name: "timeMicrosecondValue", oneof: 0
  field :time_nanosecond_value, 23, type: :int64, json_name: "timeNanosecondValue", oneof: 0

  field :interval_year_month_value, 24,
    type: :int32,
    json_name: "intervalYearMonthValue",
    oneof: 0

  field :interval_day_time_value, 25, type: :int64, json_name: "intervalDayTimeValue", oneof: 0

  field :interval_month_day_nano_value, 26,
    type: Greptime.V1.IntervalMonthDayNano,
    json_name: "intervalMonthDayNanoValue",
    oneof: 0

  field :decimal128_value, 31,
    type: Greptime.V1.Decimal128,
    json_name: "decimal128Value",
    oneof: 0
end
