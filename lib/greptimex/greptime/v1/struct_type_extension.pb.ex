defmodule Greptimex.Greptime.V1.StructTypeExtension do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.StructTypeExtension",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :fields, 1, repeated: true, type: Greptimex.Greptime.V1.StructField
end
