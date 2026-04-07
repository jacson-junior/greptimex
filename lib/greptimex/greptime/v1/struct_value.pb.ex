defmodule Greptimex.Greptime.V1.StructValue do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.StructValue",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :items, 2, repeated: true, type: Greptimex.Greptime.V1.Value
end
