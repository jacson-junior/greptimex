defmodule Greptimex.Greptime.V1.InsertIntoPlan do
  @moduledoc """
  A temporary solution for executing insert into table SELECT .. with logical plan
  since substrait to logical plan doesn't support dml yet.
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :table_name, 1, type: Greptimex.Greptime.V1.TableName, json_name: "tableName"
  field :logical_plan, 2, type: :bytes, json_name: "logicalPlan"
end
