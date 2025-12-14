defmodule Greptimex.Greptime.V1.AddColumnLocation.LocationType do
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :FIRST, 0
  field :AFTER, 1
end
