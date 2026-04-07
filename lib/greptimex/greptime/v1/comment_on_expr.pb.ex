defmodule Greptimex.Greptime.V1.CommentOnExpr do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.CommentOnExpr",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"

  field :object_type, 3,
    type: Greptimex.Greptime.V1.CommentObjectType,
    json_name: "objectType",
    enum: true

  field :object_name, 4, type: :string, json_name: "objectName"
  field :column_name, 5, type: :string, json_name: "columnName"
  field :comment, 6, type: :string
end
