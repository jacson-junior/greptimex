defmodule Greptimex.Greptime.V1.VectorTypeExtension do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.VectorTypeExtension",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :dim, 1, type: :uint32
end
