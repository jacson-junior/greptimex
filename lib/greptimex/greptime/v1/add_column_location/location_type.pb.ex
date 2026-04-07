defmodule Greptimex.Greptime.V1.AddColumnLocation.LocationType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.AddColumnLocation.LocationType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :FIRST, 0
  field :AFTER, 1
end
