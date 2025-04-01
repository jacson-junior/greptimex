defmodule Greptime.V1.GreptimeRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :request, 0

  field :header, 1, type: Greptime.V1.RequestHeader
  field :inserts, 2, type: Greptime.V1.InsertRequests, oneof: 0
  field :query, 3, type: Greptime.V1.QueryRequest, oneof: 0
  field :ddl, 4, type: Greptime.V1.DdlRequest, oneof: 0
  field :deletes, 5, type: Greptime.V1.DeleteRequests, oneof: 0
  field :row_inserts, 6, type: Greptime.V1.RowInsertRequests, json_name: "rowInserts", oneof: 0
  field :row_deletes, 7, type: Greptime.V1.RowDeleteRequests, json_name: "rowDeletes", oneof: 0
end

defmodule Greptime.V1.GreptimeResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :response, 0

  field :header, 1, type: Greptime.V1.ResponseHeader
  field :affected_rows, 2, type: Greptime.V1.AffectedRows, json_name: "affectedRows", oneof: 0
end

defmodule Greptime.V1.QueryRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :query, 0

  field :sql, 1, type: :string, oneof: 0
  field :logical_plan, 2, type: :bytes, json_name: "logicalPlan", oneof: 0

  field :prom_range_query, 3,
    type: Greptime.V1.PromRangeQuery,
    json_name: "promRangeQuery",
    oneof: 0
end

defmodule Greptime.V1.InsertRequests do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :inserts, 1, repeated: true, type: Greptime.V1.InsertRequest
end

defmodule Greptime.V1.InsertRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :table_name, 1, type: :string, json_name: "tableName"
  field :columns, 3, repeated: true, type: Greptime.V1.Column
  field :row_count, 4, type: :uint32, json_name: "rowCount"
end

defmodule Greptime.V1.DeleteRequests do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :deletes, 1, repeated: true, type: Greptime.V1.DeleteRequest
end

defmodule Greptime.V1.DeleteRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :table_name, 1, type: :string, json_name: "tableName"
  field :key_columns, 3, repeated: true, type: Greptime.V1.Column, json_name: "keyColumns"
  field :row_count, 4, type: :uint32, json_name: "rowCount"
end

defmodule Greptime.V1.RowInsertRequests do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :inserts, 1, repeated: true, type: Greptime.V1.RowInsertRequest
end

defmodule Greptime.V1.RowInsertRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :table_name, 1, type: :string, json_name: "tableName"
  field :rows, 2, type: Greptime.V1.Rows
end

defmodule Greptime.V1.RowDeleteRequests do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :deletes, 1, repeated: true, type: Greptime.V1.RowDeleteRequest
end

defmodule Greptime.V1.RowDeleteRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :table_name, 1, type: :string, json_name: "tableName"
  field :rows, 2, type: Greptime.V1.Rows
end

defmodule Greptime.V1.GreptimeDatabase.Service do
  @moduledoc false

  use GRPC.Service, name: "greptime.v1.GreptimeDatabase", protoc_gen_elixir_version: "0.14.0"

  rpc :Handle, Greptime.V1.GreptimeRequest, Greptime.V1.GreptimeResponse

  rpc :HandleRequests, stream(Greptime.V1.GreptimeRequest), Greptime.V1.GreptimeResponse
end

defmodule Greptime.V1.GreptimeDatabase.Stub do
  @moduledoc false

  use GRPC.Stub, service: Greptime.V1.GreptimeDatabase.Service
end
