defmodule Greptimex.Greptime.V1.DropDefaults do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.DropDefaults",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :drop_defaults, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.DropDefault,
    json_name: "dropDefaults"
end
