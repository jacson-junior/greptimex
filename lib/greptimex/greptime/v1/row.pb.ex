defmodule Greptimex.Greptime.V1.Row do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :values, 1, repeated: true, type: Greptimex.Greptime.V1.Value
end
