defmodule Greptimex.Greptime.V1.StructTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :fields, 1, repeated: true, type: Greptimex.Greptime.V1.StructField
end
