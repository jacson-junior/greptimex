defmodule Greptimex.Greptime.V1.GreptimeRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :request, 0

  field :header, 1, type: Greptimex.Greptime.V1.RequestHeader
  field :inserts, 2, type: Greptimex.Greptime.V1.InsertRequests, oneof: 0
  field :query, 3, type: Greptimex.Greptime.V1.QueryRequest, oneof: 0
  field :ddl, 4, type: Greptimex.Greptime.V1.DdlRequest, oneof: 0
  field :deletes, 5, type: Greptimex.Greptime.V1.DeleteRequests, oneof: 0

  field :row_inserts, 6,
    type: Greptimex.Greptime.V1.RowInsertRequests,
    json_name: "rowInserts",
    oneof: 0

  field :row_deletes, 7,
    type: Greptimex.Greptime.V1.RowDeleteRequests,
    json_name: "rowDeletes",
    oneof: 0
end
