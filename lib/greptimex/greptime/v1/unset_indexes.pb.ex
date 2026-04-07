defmodule Greptimex.Greptime.V1.UnsetIndexes do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.UnsetIndexes",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :unset_indexes, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.UnsetIndex,
    json_name: "unsetIndexes"
end
