defmodule Greptimex.Greptime.V1.PartitionedSource do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.PartitionedSource",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :exprs, 1, repeated: true, type: :string

  field :target_partition_columns, 2,
    type: Greptimex.Greptime.V1.TargetPartitionColumns,
    json_name: "targetPartitionColumns"
end
