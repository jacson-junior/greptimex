defmodule Greptimex.Greptime.V1.InsertRequests do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.InsertRequests",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :inserts, 1, repeated: true, type: Greptimex.Greptime.V1.InsertRequest
end
