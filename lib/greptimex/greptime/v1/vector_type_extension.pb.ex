defmodule Greptimex.Greptime.V1.VectorTypeExtension do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :dim, 1, type: :uint32
end
