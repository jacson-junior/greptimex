defmodule Greptimex.Greptime.V1.ColumnDataType do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :BOOLEAN, 0
  field :INT8, 1
  field :INT16, 2
  field :INT32, 3
  field :INT64, 4
  field :UINT8, 5
  field :UINT16, 6
  field :UINT32, 7
  field :UINT64, 8
  field :FLOAT32, 9
  field :FLOAT64, 10
  field :BINARY, 11
  field :STRING, 12
  field :DATE, 13
  field :DATETIME, 14
  field :TIMESTAMP_SECOND, 15
  field :TIMESTAMP_MILLISECOND, 16
  field :TIMESTAMP_MICROSECOND, 17
  field :TIMESTAMP_NANOSECOND, 18
  field :TIME_SECOND, 19
  field :TIME_MILLISECOND, 20
  field :TIME_MICROSECOND, 21
  field :TIME_NANOSECOND, 22
  field :INTERVAL_YEAR_MONTH, 23
  field :INTERVAL_DAY_TIME, 24
  field :INTERVAL_MONTH_DAY_NANO, 25
  field :DECIMAL128, 30
  field :JSON, 31
  field :VECTOR, 32
  field :LIST, 40
  field :STRUCT, 41
  field :DICTIONARY, 42
end
