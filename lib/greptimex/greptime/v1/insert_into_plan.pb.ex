defmodule Greptimex.Greptime.V1.InsertIntoPlan do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.InsertIntoPlan",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :table_name, 1, type: Greptimex.Greptime.V1.TableName, json_name: "tableName"
  field :logical_plan, 2, type: :bytes, json_name: "logicalPlan"
end
