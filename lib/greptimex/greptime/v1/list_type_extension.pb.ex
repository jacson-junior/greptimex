defmodule Greptimex.Greptime.V1.ListTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :datatype, 1, type: Greptimex.Greptime.V1.ColumnDataType, enum: true

  field :datatype_extension, 2,
    type: Greptimex.Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"
end
