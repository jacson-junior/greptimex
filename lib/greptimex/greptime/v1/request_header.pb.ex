defmodule Greptimex.Greptime.V1.RequestHeader do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog, 1, type: :string
  field :schema, 2, type: :string
  field :authorization, 3, type: Greptimex.Greptime.V1.AuthHeader
  field :dbname, 4, type: :string

  field :tracing_context, 5,
    repeated: true,
    type: Greptimex.Greptime.V1.RequestHeader.TracingContextEntry,
    json_name: "tracingContext",
    map: true

  field :timezone, 6, type: :string
end
