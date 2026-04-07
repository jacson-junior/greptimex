defmodule Greptimex.Greptime.V1.ListValue do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ListValue",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :items, 1, repeated: true, type: Greptimex.Greptime.V1.Value
end
