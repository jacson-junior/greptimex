defmodule Greptimex.Greptime.V1.UnsetDatabaseOptions do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.UnsetDatabaseOptions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :keys, 1, repeated: true, type: :string
end
