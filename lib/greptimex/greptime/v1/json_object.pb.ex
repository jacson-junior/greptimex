defmodule Greptimex.Greptime.V1.JsonObject do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.JsonObject",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :entries, 1, repeated: true, type: Greptimex.Greptime.V1.JsonObject.Entry
end
