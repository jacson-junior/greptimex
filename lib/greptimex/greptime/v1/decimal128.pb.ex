defmodule Greptimex.Greptime.V1.Decimal128 do
  @moduledoc """
  (hi: high 64 bits, lo: low 64 bits) are used to keep the decimal128 value.
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :hi, 1, type: :int64
  field :lo, 2, type: :int64
end
