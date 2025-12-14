defmodule Greptimex.Greptime.V1.ModifyColumnType do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"

  field :target_type, 2,
    type: Greptimex.Greptime.V1.ColumnDataType,
    json_name: "targetType",
    enum: true

  field :target_type_extension, 3,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "targetTypeExtension"
end
