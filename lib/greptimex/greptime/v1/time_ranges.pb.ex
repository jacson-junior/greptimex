defmodule Greptimex.Greptime.V1.TimeRanges do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.TimeRanges",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :time_unit, 1, type: Greptimex.Greptime.V1.TimeUnit, json_name: "timeUnit", enum: true

  field :time_ranges, 2,
    repeated: true,
    type: Greptimex.Greptime.V1.TimeRange,
    json_name: "timeRanges"
end
