defmodule Greptimex.Greptime.V1.ResponseHeader do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ResponseHeader",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :status, 1, type: Greptimex.Greptime.V1.Status
end
