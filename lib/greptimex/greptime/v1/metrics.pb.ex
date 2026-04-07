defmodule Greptimex.Greptime.V1.Metrics do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Metrics",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :metrics, 1, type: :bytes
end
