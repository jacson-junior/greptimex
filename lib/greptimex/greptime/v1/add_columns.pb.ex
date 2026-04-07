defmodule Greptimex.Greptime.V1.AddColumns do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.AddColumns",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :add_columns, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.AddColumn,
    json_name: "addColumns"
end
