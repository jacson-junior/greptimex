defmodule Greptimex.Greptime.V1.DecimalTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :precision, 1, type: :int32
  field :scale, 2, type: :int32
end
