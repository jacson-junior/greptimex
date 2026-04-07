defmodule Greptimex.Greptime.V1.Repartition do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Repartition",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :from_partition_exprs, 1, repeated: true, type: :string, json_name: "fromPartitionExprs"
  field :into_partition_exprs, 2, repeated: true, type: :string, json_name: "intoPartitionExprs"
end
