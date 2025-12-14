defmodule Greptimex.Greptime.V1.AlterDatabaseExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :kind, 0

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"

  field :set_database_options, 3,
    type: Greptimex.Greptime.V1.SetDatabaseOptions,
    json_name: "setDatabaseOptions",
    oneof: 0

  field :unset_database_options, 4,
    type: Greptimex.Greptime.V1.UnsetDatabaseOptions,
    json_name: "unsetDatabaseOptions",
    oneof: 0
end
