defmodule Greptimex.Greptime.V1.UnsetIndex do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.UnsetIndex",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  oneof :options, 0

  field :fulltext, 1, type: Greptimex.Greptime.V1.UnsetFulltext, oneof: 0
  field :inverted, 2, type: Greptimex.Greptime.V1.UnsetInverted, oneof: 0
  field :skipping, 3, type: Greptimex.Greptime.V1.UnsetSkipping, oneof: 0
end
