defmodule Greptimex.Greptime.V1.TimeUnit do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.TimeUnit",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :MILLISECOND, 0
  field :SECOND, 1
  field :MICROSECOND, 2
  field :NANOSECOND, 3
end
