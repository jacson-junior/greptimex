defmodule Greptimex.Greptime.V1.PromqlRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :promql, 0

  field :header, 1, type: Greptimex.Greptime.V1.RequestHeader

  field :instant_query, 2,
    type: Greptimex.Greptime.V1.PromInstantQuery,
    json_name: "instantQuery",
    oneof: 0

  field :range_query, 3,
    type: Greptimex.Greptime.V1.PromRangeQuery,
    json_name: "rangeQuery",
    oneof: 0
end
