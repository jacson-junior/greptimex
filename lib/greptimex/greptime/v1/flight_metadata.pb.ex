defmodule Greptimex.Greptime.V1.FlightMetadata do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :affected_rows, 1, type: Greptimex.Greptime.V1.AffectedRows, json_name: "affectedRows"
  field :metrics, 2, type: Greptimex.Greptime.V1.Metrics
end
