defmodule Greptimex.Greptime.V1.SetIndexes do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :set_indexes, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.SetIndex,
    json_name: "setIndexes"
end
