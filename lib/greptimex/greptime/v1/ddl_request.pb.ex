defmodule Greptimex.Greptime.V1.DdlRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :expr, 0

  field :create_database, 1,
    type: Greptimex.Greptime.V1.CreateDatabaseExpr,
    json_name: "createDatabase",
    oneof: 0

  field :create_table, 2,
    type: Greptimex.Greptime.V1.CreateTableExpr,
    json_name: "createTable",
    oneof: 0

  field :alter_table, 3,
    type: Greptimex.Greptime.V1.AlterTableExpr,
    json_name: "alterTable",
    oneof: 0

  field :drop_table, 4,
    type: Greptimex.Greptime.V1.DropTableExpr,
    json_name: "dropTable",
    oneof: 0

  field :truncate_table, 7,
    type: Greptimex.Greptime.V1.TruncateTableExpr,
    json_name: "truncateTable",
    oneof: 0

  field :create_flow, 8,
    type: Greptimex.Greptime.V1.CreateFlowExpr,
    json_name: "createFlow",
    oneof: 0

  field :drop_flow, 9, type: Greptimex.Greptime.V1.DropFlowExpr, json_name: "dropFlow", oneof: 0

  field :create_view, 10,
    type: Greptimex.Greptime.V1.CreateViewExpr,
    json_name: "createView",
    oneof: 0

  field :drop_view, 11, type: Greptimex.Greptime.V1.DropViewExpr, json_name: "dropView", oneof: 0

  field :alter_database, 12,
    type: Greptimex.Greptime.V1.AlterDatabaseExpr,
    json_name: "alterDatabase",
    oneof: 0
end
