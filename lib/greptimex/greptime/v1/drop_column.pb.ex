defmodule Greptimex.Greptime.V1.DropColumn do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.DropColumn",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :name, 1, type: :string
end
