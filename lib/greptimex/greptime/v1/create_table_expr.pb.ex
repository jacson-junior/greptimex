defmodule Greptimex.Greptime.V1.CreateTableExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :desc, 4, type: :string

  field :column_defs, 5,
    repeated: true,
    type: Greptimex.Greptime.V1.ColumnDef,
    json_name: "columnDefs"

  field :time_index, 6, type: :string, json_name: "timeIndex"
  field :primary_keys, 7, repeated: true, type: :string, json_name: "primaryKeys"
  field :create_if_not_exists, 8, type: :bool, json_name: "createIfNotExists"

  field :table_options, 9,
    repeated: true,
    type: Greptimex.Greptime.V1.CreateTableExpr.TableOptionsEntry,
    json_name: "tableOptions",
    map: true

  field :table_id, 10, type: Greptimex.Greptime.V1.TableId, json_name: "tableId"
  field :engine, 12, type: :string
end
