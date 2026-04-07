defmodule Greptimex.Greptime.V1.SetDatabaseOptions do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.SetDatabaseOptions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :set_database_options, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.Option,
    json_name: "setDatabaseOptions"
end
