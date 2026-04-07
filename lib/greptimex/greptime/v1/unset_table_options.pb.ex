defmodule Greptimex.Greptime.V1.UnsetTableOptions do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.UnsetTableOptions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :keys, 1, repeated: true, type: :string
end
