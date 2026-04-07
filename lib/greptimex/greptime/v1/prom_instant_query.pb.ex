defmodule Greptimex.Greptime.V1.PromInstantQuery do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.PromInstantQuery",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :query, 1, type: :string
  field :time, 2, type: :string
  field :lookback, 3, type: :string
end
