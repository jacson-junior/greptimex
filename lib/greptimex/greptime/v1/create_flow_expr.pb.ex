defmodule Greptimex.Greptime.V1.CreateFlowExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :flow_name, 2, type: :string, json_name: "flowName"

  field :source_table_names, 3,
    repeated: true,
    type: Greptimex.Greptime.V1.TableName,
    json_name: "sourceTableNames"

  field :sink_table_name, 4, type: Greptimex.Greptime.V1.TableName, json_name: "sinkTableName"
  field :or_replace, 5, type: :bool, json_name: "orReplace"
  field :create_if_not_exists, 6, type: :bool, json_name: "createIfNotExists"
  field :expire_after, 7, type: Greptimex.Greptime.V1.ExpireAfter, json_name: "expireAfter"
  field :eval_interval, 11, type: Greptimex.Greptime.V1.EvalInterval, json_name: "evalInterval"
  field :comment, 8, type: :string
  field :sql, 9, type: :string

  field :flow_options, 10,
    repeated: true,
    type: Greptimex.Greptime.V1.CreateFlowExpr.FlowOptionsEntry,
    json_name: "flowOptions",
    map: true
end
