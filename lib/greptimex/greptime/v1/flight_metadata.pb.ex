defmodule Greptimex.Greptime.V1.FlightMetadata do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.FlightMetadata",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :affected_rows, 1, type: Greptimex.Greptime.V1.AffectedRows, json_name: "affectedRows"
  field :metrics, 2, type: Greptimex.Greptime.V1.Metrics
end
