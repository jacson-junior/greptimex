defmodule Greptimex.Greptime.V1.Token do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Token",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :token, 1, type: :string
end
