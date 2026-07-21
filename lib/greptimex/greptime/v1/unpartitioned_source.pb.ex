defmodule Greptimex.Greptime.V1.UnpartitionedSource do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.UnpartitionedSource",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :partition_columns, 1, repeated: true, type: :string, json_name: "partitionColumns"
end
