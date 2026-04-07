defmodule Greptimex.Greptime.V1.Row do
  @moduledoc false

  use Protobuf, full_name: "greptime.v1.Row", protoc_gen_elixir_version: "0.16.0", syntax: :proto3

  field :values, 1, repeated: true, type: Greptimex.Greptime.V1.Value
end
