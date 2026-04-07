defmodule Greptimex.Greptime.V1.SkippingIndexType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.SkippingIndexType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :BLOOM_FILTER, 0
end
