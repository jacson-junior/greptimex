defmodule Greptimex.Greptime.V1.DeleteRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :table_name, 1, type: :string, json_name: "tableName"

  field :key_columns, 3,
    repeated: true,
    type: Greptimex.Greptime.V1.Column,
    json_name: "keyColumns"

  field :row_count, 4, type: :uint32, json_name: "rowCount"
end
