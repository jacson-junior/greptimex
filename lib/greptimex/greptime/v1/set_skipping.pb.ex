defmodule Greptimex.Greptime.V1.SetSkipping do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :enable, 2, type: :bool
  field :granularity, 3, type: :uint64

  field :skipping_index_type, 4,
    type: Greptimex.Greptime.V1.SkippingIndexType,
    json_name: "skippingIndexType",
    enum: true

  field :false_positive_rate, 5, type: :double, json_name: "falsePositiveRate"
end
