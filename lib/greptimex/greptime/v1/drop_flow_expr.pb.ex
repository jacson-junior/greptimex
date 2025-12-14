defmodule Greptimex.Greptime.V1.DropFlowExpr do
  @moduledoc """
  Drop a flow.
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :flow_name, 2, type: :string, json_name: "flowName"
  field :flow_id, 3, type: Greptimex.Greptime.V1.FlowId, json_name: "flowId"
  field :drop_if_exists, 5, type: :bool, json_name: "dropIfExists"
end
