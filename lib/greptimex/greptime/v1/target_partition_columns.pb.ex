defmodule Greptimex.Greptime.V1.TargetPartitionColumns do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.TargetPartitionColumns",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :columns, 1, repeated: true, type: :string
end
