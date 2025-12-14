defmodule Greptimex.Greptime.V1.DropViewExpr do
  @moduledoc """
  Drop a view
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :view_name, 3, type: :string, json_name: "viewName"
  field :view_id, 4, type: Greptimex.Greptime.V1.TableId, json_name: "viewId"
  field :drop_if_exists, 5, type: :bool, json_name: "dropIfExists"
end
