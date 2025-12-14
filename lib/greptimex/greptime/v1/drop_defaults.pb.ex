defmodule Greptimex.Greptime.V1.DropDefaults do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :drop_defaults, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.DropDefault,
    json_name: "dropDefaults"
end
