defmodule Greptimex.Greptime.V1.DecimalTypeExtension do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.DecimalTypeExtension",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :precision, 1, type: :int32
  field :scale, 2, type: :int32
end
