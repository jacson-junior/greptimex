defmodule Greptimex.Greptime.V1.Option do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Option",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end
