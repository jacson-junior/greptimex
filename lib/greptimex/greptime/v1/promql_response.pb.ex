defmodule Greptimex.Greptime.V1.PromqlResponse do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.PromqlResponse",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :header, 1, type: Greptimex.Greptime.V1.ResponseHeader
  field :body, 2, type: :bytes
end
