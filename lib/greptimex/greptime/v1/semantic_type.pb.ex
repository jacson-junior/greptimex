defmodule Greptimex.Greptime.V1.SemanticType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.SemanticType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :TAG, 0
  field :FIELD, 1
  field :TIMESTAMP, 2
end
