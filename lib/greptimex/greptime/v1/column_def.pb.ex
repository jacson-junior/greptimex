defmodule Greptimex.Greptime.V1.ColumnDef do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :name, 1, type: :string

  field :data_type, 2,
    type: Greptimex.Greptime.V1.ColumnDataType,
    json_name: "dataType",
    enum: true

  field :is_nullable, 3, type: :bool, json_name: "isNullable"
  field :default_constraint, 4, type: :bytes, json_name: "defaultConstraint"

  field :semantic_type, 5,
    type: Greptimex.Greptime.V1.SemanticType,
    json_name: "semanticType",
    enum: true

  field :comment, 6, type: :string

  field :datatype_extension, 7,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"

  field :options, 8, type: Greptimex.Greptime.V1.ColumnOptions
end
