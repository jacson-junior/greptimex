defmodule Greptimex.Greptime.V1.FulltextBackend do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.FulltextBackend",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :TANTIVY, 0
  field :BLOOM, 1
end
