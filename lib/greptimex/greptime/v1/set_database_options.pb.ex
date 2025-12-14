defmodule Greptimex.Greptime.V1.SetDatabaseOptions do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :set_database_options, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.Option,
    json_name: "setDatabaseOptions"
end
