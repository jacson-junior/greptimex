defmodule Greptimex.Greptime.V1.ExplainOptions do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ExplainOptions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :verbose, 1, type: :bool
end
