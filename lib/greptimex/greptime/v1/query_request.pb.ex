defmodule Greptimex.Greptime.V1.QueryRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :query, 0

  field :sql, 1, type: :string, oneof: 0
  field :logical_plan, 2, type: :bytes, json_name: "logicalPlan", oneof: 0

  field :prom_range_query, 3,
    type: Greptimex.Greptime.V1.PromRangeQuery,
    json_name: "promRangeQuery",
    oneof: 0

  field :insert_into_plan, 4,
    type: Greptimex.Greptime.V1.InsertIntoPlan,
    json_name: "insertIntoPlan",
    oneof: 0
end
