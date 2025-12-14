defmodule Greptimex.Greptime.V1.Rows do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :schema, 1, repeated: true, type: Greptimex.Greptime.V1.ColumnSchema
  field :rows, 2, repeated: true, type: Greptimex.Greptime.V1.Row
end
