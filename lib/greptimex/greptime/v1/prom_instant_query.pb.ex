defmodule Greptimex.Greptime.V1.PromInstantQuery do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :query, 1, type: :string
  field :time, 2, type: :string
  field :lookback, 3, type: :string
end
