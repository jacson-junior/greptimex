defmodule Greptimex.Greptime.V1.SetTableOptions do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :table_options, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.Option,
    json_name: "tableOptions"
end
