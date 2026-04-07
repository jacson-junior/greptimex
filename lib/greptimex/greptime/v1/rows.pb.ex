defmodule Greptimex.Greptime.V1.Rows do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Rows",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :schema, 1, repeated: true, type: Greptimex.Greptime.V1.ColumnSchema
  field :rows, 2, repeated: true, type: Greptimex.Greptime.V1.Row
end
