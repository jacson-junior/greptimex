defmodule Greptimex.Greptime.V1.SetDefaults do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :set_defaults, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.SetDefault,
    json_name: "setDefaults"
end
