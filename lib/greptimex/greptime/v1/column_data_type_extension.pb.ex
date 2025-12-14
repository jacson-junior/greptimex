defmodule Greptimex.Greptime.V1.ColumnDataTypeExtension do
  @moduledoc """
  Type extension for some complex types
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :type_ext, 0

  field :decimal_type, 1,
    type: Greptimex.Greptime.V1.DecimalTypeExtension,
    json_name: "decimalType",
    oneof: 0

  field :json_type, 2,
    type: Greptimex.Greptime.V1.JsonTypeExtension,
    json_name: "jsonType",
    enum: true,
    oneof: 0

  field :vector_type, 3,
    type: Greptimex.Greptime.V1.VectorTypeExtension,
    json_name: "vectorType",
    oneof: 0

  field :list_type, 4,
    type: Greptimex.Greptime.V1.ListTypeExtension,
    json_name: "listType",
    oneof: 0

  field :struct_type, 5,
    type: Greptimex.Greptime.V1.StructTypeExtension,
    json_name: "structType",
    oneof: 0

  field :json_native_type, 6,
    type: Greptimex.Greptime.V1.JsonNativeTypeExtension,
    json_name: "jsonNativeType",
    oneof: 0

  field :dictionary_type, 7,
    type: Greptimex.Greptime.V1.DictionaryTypeExtension,
    json_name: "dictionaryType",
    oneof: 0
end
