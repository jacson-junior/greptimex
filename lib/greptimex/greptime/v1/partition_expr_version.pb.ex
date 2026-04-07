defmodule Greptimex.Greptime.V1.PartitionExprVersion do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.PartitionExprVersion",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :value, 1, type: :uint64
end
