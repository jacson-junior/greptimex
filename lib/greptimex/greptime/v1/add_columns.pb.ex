defmodule Greptimex.Greptime.V1.AddColumns do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :add_columns, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.AddColumn,
    json_name: "addColumns"
end
