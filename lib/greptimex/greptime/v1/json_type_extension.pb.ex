defmodule Greptimex.Greptime.V1.JsonTypeExtension do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.JsonTypeExtension",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :JSON_BINARY, 0
end
