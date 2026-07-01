defmodule Greptimex.Greptime.V1.Repartition do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Repartition",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  oneof :source, 0

  field :from_partition_exprs, 1,
    repeated: true,
    type: :string,
    json_name: "fromPartitionExprs",
    deprecated: true

  field :into_partition_exprs, 2, repeated: true, type: :string, json_name: "intoPartitionExprs"

  field :partition_exprs, 3,
    type: Greptimex.Greptime.V1.PartitionedSource,
    json_name: "partitionExprs",
    oneof: 0

  field :unpartitioned, 4, type: Greptimex.Greptime.V1.UnpartitionedSource, oneof: 0
end
