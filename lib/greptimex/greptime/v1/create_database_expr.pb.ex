defmodule Greptimex.Greptime.V1.CreateDatabaseExpr do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :create_if_not_exists, 3, type: :bool, json_name: "createIfNotExists"

  field :options, 4,
    repeated: true,
    type: Greptimex.Greptime.V1.CreateDatabaseExpr.OptionsEntry,
    map: true
end
