defmodule Greptimex.Greptime.V1.RowDeleteRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :table_name, 1, type: :string, json_name: "tableName"
  field :rows, 2, type: Greptimex.Greptime.V1.Rows
end
