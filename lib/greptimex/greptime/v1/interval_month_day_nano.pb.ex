defmodule Greptimex.Greptime.V1.IntervalMonthDayNano do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :months, 1, type: :int32
  field :days, 2, type: :int32
  field :nanoseconds, 3, type: :int64
end
