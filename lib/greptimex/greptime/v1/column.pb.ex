defmodule Greptimex.Greptime.V1.Column do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"

  field :semantic_type, 2,
    type: Greptimex.Greptime.V1.SemanticType,
    json_name: "semanticType",
    enum: true

  field :values, 3, type: Greptimex.Greptime.V1.Column.Values
  field :null_mask, 4, type: :bytes, json_name: "nullMask"
  field :datatype, 5, type: Greptimex.Greptime.V1.ColumnDataType, enum: true

  field :datatype_extension, 6,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"

  field :options, 7, type: Greptimex.Greptime.V1.ColumnOptions
end
