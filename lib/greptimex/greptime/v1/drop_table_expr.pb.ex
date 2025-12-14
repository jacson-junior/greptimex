defmodule Greptimex.Greptime.V1.DropTableExpr do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :table_id, 4, type: Greptimex.Greptime.V1.TableId, json_name: "tableId"
  field :drop_if_exists, 5, type: :bool, json_name: "dropIfExists"
end
