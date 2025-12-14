defmodule Greptimex.Greptime.V1.TimeRange do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :start, 1, type: :int64
  field :end, 2, type: :int64
end
