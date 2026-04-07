defmodule Greptimex.Greptime.V1.RowDeleteRequests do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.RowDeleteRequests",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :deletes, 1, repeated: true, type: Greptimex.Greptime.V1.RowDeleteRequest
end
