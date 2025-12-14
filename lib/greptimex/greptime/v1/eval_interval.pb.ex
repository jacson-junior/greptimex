defmodule Greptimex.Greptime.V1.EvalInterval do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :seconds, 1, type: :int64
end
