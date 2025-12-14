defmodule Greptimex.Greptime.V1.SetFulltext do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :enable, 2, type: :bool
  field :analyzer, 3, type: Greptimex.Greptime.V1.Analyzer, enum: true
  field :case_sensitive, 4, type: :bool, json_name: "caseSensitive"
  field :backend, 5, type: Greptimex.Greptime.V1.FulltextBackend, enum: true
  field :granularity, 6, type: :uint64
  field :false_positive_rate, 7, type: :double, json_name: "falsePositiveRate"
end
