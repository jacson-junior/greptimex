defmodule Greptimex.Greptime.V1.EvalInterval do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.EvalInterval",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :seconds, 1, type: :int64
end
