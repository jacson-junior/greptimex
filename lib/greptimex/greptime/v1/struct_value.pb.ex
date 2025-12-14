defmodule Greptimex.Greptime.V1.StructValue do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :items, 2, repeated: true, type: Greptimex.Greptime.V1.Value
end
