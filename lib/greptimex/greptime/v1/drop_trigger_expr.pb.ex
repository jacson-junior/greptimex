defmodule Greptimex.Greptime.V1.DropTriggerExpr do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :trigger_name, 2, type: :string, json_name: "triggerName"
  field :drop_if_exists, 3, type: :bool, json_name: "dropIfExists"
end
