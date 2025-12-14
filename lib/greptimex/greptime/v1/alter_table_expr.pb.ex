defmodule Greptimex.Greptime.V1.AlterTableExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :kind, 0

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :add_columns, 4, type: Greptimex.Greptime.V1.AddColumns, json_name: "addColumns", oneof: 0

  field :drop_columns, 5,
    type: Greptimex.Greptime.V1.DropColumns,
    json_name: "dropColumns",
    oneof: 0

  field :rename_table, 6,
    type: Greptimex.Greptime.V1.RenameTable,
    json_name: "renameTable",
    oneof: 0

  field :modify_column_types, 7,
    type: Greptimex.Greptime.V1.ModifyColumnTypes,
    json_name: "modifyColumnTypes",
    oneof: 0

  field :set_table_options, 8,
    type: Greptimex.Greptime.V1.SetTableOptions,
    json_name: "setTableOptions",
    oneof: 0

  field :unset_table_options, 11,
    type: Greptimex.Greptime.V1.UnsetTableOptions,
    json_name: "unsetTableOptions",
    oneof: 0

  field :set_index, 12, type: Greptimex.Greptime.V1.SetIndex, json_name: "setIndex", oneof: 0

  field :unset_index, 13,
    type: Greptimex.Greptime.V1.UnsetIndex,
    json_name: "unsetIndex",
    oneof: 0

  field :drop_defaults, 14,
    type: Greptimex.Greptime.V1.DropDefaults,
    json_name: "dropDefaults",
    oneof: 0

  field :set_indexes, 15,
    type: Greptimex.Greptime.V1.SetIndexes,
    json_name: "setIndexes",
    oneof: 0

  field :unset_indexes, 16,
    type: Greptimex.Greptime.V1.UnsetIndexes,
    json_name: "unsetIndexes",
    oneof: 0

  field :set_defaults, 17,
    type: Greptimex.Greptime.V1.SetDefaults,
    json_name: "setDefaults",
    oneof: 0
end
