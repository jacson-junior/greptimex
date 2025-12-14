defmodule Greptimex.Greptime.V1.DropColumns do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :drop_columns, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.DropColumn,
    json_name: "dropColumns"
end
