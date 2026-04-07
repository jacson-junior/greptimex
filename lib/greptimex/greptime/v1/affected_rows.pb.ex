defmodule Greptimex.Greptime.V1.AffectedRows do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.AffectedRows",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :value, 1, type: :uint32
end
