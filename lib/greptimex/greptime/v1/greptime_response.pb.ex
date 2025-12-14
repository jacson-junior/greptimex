defmodule Greptimex.Greptime.V1.GreptimeResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :response, 0

  field :header, 1, type: Greptimex.Greptime.V1.ResponseHeader

  field :affected_rows, 2,
    type: Greptimex.Greptime.V1.AffectedRows,
    json_name: "affectedRows",
    oneof: 0
end
