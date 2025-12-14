defmodule Greptimex.Greptime.V1.Decimal128 do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :hi, 1, type: :int64
  field :lo, 2, type: :int64
end
