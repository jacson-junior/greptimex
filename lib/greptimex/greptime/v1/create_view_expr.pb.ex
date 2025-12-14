defmodule Greptimex.Greptime.V1.CreateViewExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :view_name, 3, type: :string, json_name: "viewName"
  field :logical_plan, 4, type: :bytes, json_name: "logicalPlan"
  field :create_if_not_exists, 5, type: :bool, json_name: "createIfNotExists"
  field :or_replace, 6, type: :bool, json_name: "orReplace"

  field :table_names, 7,
    repeated: true,
    type: Greptimex.Greptime.V1.TableName,
    json_name: "tableNames"

  field :columns, 8, repeated: true, type: :string
  field :plan_columns, 9, repeated: true, type: :string, json_name: "planColumns"
  field :definition, 10, type: :string
end
