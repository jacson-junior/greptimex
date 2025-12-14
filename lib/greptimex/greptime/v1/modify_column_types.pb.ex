defmodule Greptimex.Greptime.V1.ModifyColumnTypes do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :modify_column_types, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.ModifyColumnType,
    json_name: "modifyColumnTypes"
end
