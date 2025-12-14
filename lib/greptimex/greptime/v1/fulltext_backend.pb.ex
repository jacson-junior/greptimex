defmodule Greptimex.Greptime.V1.FulltextBackend do
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :TANTIVY, 0
  field :BLOOM, 1
end
