defmodule Greptimex.Greptime.V1.ModifyColumnTypes do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ModifyColumnTypes",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :modify_column_types, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.ModifyColumnType,
    json_name: "modifyColumnTypes"
end
