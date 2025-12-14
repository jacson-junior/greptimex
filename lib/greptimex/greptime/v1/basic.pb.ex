defmodule Greptimex.Greptime.V1.Basic do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :username, 1, type: :string
  field :password, 2, type: :string
end
