defmodule Greptimex.Greptime.V1.UnsetTableOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :keys, 1, repeated: true, type: :string
end
