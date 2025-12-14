defmodule Greptimex.Greptime.V1.Token do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :token, 1, type: :string
end
