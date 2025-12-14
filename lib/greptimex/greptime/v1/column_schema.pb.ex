defmodule Greptimex.Greptime.V1.ColumnSchema do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :datatype, 2, type: Greptimex.Greptime.V1.ColumnDataType, enum: true

  field :semantic_type, 3,
    type: Greptimex.Greptime.V1.SemanticType,
    json_name: "semanticType",
    enum: true

  field :datatype_extension, 4,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"

  field :options, 5, type: Greptimex.Greptime.V1.ColumnOptions
end
