defmodule Greptimex.Greptime.V1.TimeUnit do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :MILLISECOND, 0
  field :SECOND, 1
  field :MICROSECOND, 2
  field :NANOSECOND, 3
end
