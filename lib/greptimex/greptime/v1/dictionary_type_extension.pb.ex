defmodule Greptimex.Greptime.V1.DictionaryTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :key_datatype, 1,
    type: Greptimex.Greptime.V1.ColumnDataType,
    json_name: "keyDatatype",
    enum: true

  field :key_datatype_extension, 2,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "keyDatatypeExtension"

  field :value_datatype, 3,
    type: Greptimex.Greptime.V1.ColumnDataType,
    json_name: "valueDatatype",
    enum: true

  field :value_datatype_extension, 4,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "valueDatatypeExtension"
end
