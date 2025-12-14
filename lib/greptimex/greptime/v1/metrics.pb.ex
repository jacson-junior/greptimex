defmodule Greptimex.Greptime.V1.Metrics do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :metrics, 1, type: :bytes
end
