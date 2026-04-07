defmodule Greptimex.Greptime.V1.StructField do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.StructField",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :name, 1, type: :string
  field :datatype, 2, type: Greptimex.Greptime.V1.ColumnDataType, enum: true

  field :datatype_extension, 3,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"
end
