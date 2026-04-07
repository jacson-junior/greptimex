defmodule Greptimex.Greptime.V1.Basic do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Basic",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :username, 1, type: :string
  field :password, 2, type: :string
end
