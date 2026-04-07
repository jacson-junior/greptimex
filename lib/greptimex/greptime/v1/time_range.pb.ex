defmodule Greptimex.Greptime.V1.TimeRange do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.TimeRange",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :start, 1, type: :int64
  field :end, 2, type: :int64
end
