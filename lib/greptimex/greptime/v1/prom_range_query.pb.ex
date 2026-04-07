defmodule Greptimex.Greptime.V1.PromRangeQuery do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.PromRangeQuery",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :query, 1, type: :string
  field :start, 2, type: :string
  field :end, 3, type: :string
  field :step, 4, type: :string
  field :lookback, 5, type: :string
end
