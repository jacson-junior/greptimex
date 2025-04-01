defmodule Greptime.V1.SemanticType do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :TAG, 0
  field :FIELD, 1
  field :TIMESTAMP, 2
end

defmodule Greptime.V1.ColumnDataType do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :BOOLEAN, 0
  field :INT8, 1
  field :INT16, 2
  field :INT32, 3
  field :INT64, 4
  field :UINT8, 5
  field :UINT16, 6
  field :UINT32, 7
  field :UINT64, 8
  field :FLOAT32, 9
  field :FLOAT64, 10
  field :BINARY, 11
  field :STRING, 12
  field :DATE, 13
  field :DATETIME, 14
  field :TIMESTAMP_SECOND, 15
  field :TIMESTAMP_MILLISECOND, 16
  field :TIMESTAMP_MICROSECOND, 17
  field :TIMESTAMP_NANOSECOND, 18
  field :TIME_SECOND, 19
  field :TIME_MILLISECOND, 20
  field :TIME_MICROSECOND, 21
  field :TIME_NANOSECOND, 22
  field :INTERVAL_YEAR_MONTH, 23
  field :INTERVAL_DAY_TIME, 24
  field :INTERVAL_MONTH_DAY_NANO, 25
  field :DECIMAL128, 30
  field :JSON, 31
  field :VECTOR, 32
end

defmodule Greptime.V1.JsonTypeExtension do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :JSON_BINARY, 0
end

defmodule Greptime.V1.QueryContext.ExtensionsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.QueryContext do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :current_catalog, 1, type: :string, json_name: "currentCatalog"
  field :current_schema, 2, type: :string, json_name: "currentSchema"
  field :timezone, 4, type: :string
  field :extensions, 5, repeated: true, type: Greptime.V1.QueryContext.ExtensionsEntry, map: true
  field :channel, 6, type: :uint32
  field :snapshot_seqs, 7, type: Greptime.V1.SnapshotSequences, json_name: "snapshotSeqs"
  field :explain, 8, type: Greptime.V1.ExplainOptions
end

defmodule Greptime.V1.SnapshotSequences.SnapshotSeqsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :uint64
  field :value, 2, type: :uint64
end

defmodule Greptime.V1.SnapshotSequences do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :snapshot_seqs, 7,
    repeated: true,
    type: Greptime.V1.SnapshotSequences.SnapshotSeqsEntry,
    json_name: "snapshotSeqs",
    map: true
end

defmodule Greptime.V1.ExplainOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :verbose, 1, type: :bool
end

defmodule Greptime.V1.RequestHeader.TracingContextEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.RequestHeader do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog, 1, type: :string
  field :schema, 2, type: :string
  field :authorization, 3, type: Greptime.V1.AuthHeader
  field :dbname, 4, type: :string

  field :tracing_context, 5,
    repeated: true,
    type: Greptime.V1.RequestHeader.TracingContextEntry,
    json_name: "tracingContext",
    map: true

  field :timezone, 6, type: :string
end

defmodule Greptime.V1.ResponseHeader do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :status, 1, type: Greptime.V1.Status
end

defmodule Greptime.V1.Status do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :status_code, 1, type: :uint32, json_name: "statusCode"
  field :err_msg, 2, type: :string, json_name: "errMsg"
end

defmodule Greptime.V1.AuthHeader do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :auth_scheme, 0

  field :basic, 1, type: Greptime.V1.Basic, oneof: 0
  field :token, 2, type: Greptime.V1.Token, oneof: 0
end

defmodule Greptime.V1.Basic do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :username, 1, type: :string
  field :password, 2, type: :string
end

defmodule Greptime.V1.Token do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :token, 1, type: :string
end

defmodule Greptime.V1.TableName do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
end

defmodule Greptime.V1.AffectedRows do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :value, 1, type: :uint32
end

defmodule Greptime.V1.Metrics do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :metrics, 1, type: :bytes
end

defmodule Greptime.V1.ExpireAfter do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :value, 1, type: :int64
end

defmodule Greptime.V1.FlightMetadata do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :affected_rows, 1, type: Greptime.V1.AffectedRows, json_name: "affectedRows"
  field :metrics, 2, type: Greptime.V1.Metrics
end

defmodule Greptime.V1.IntervalMonthDayNano do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :months, 1, type: :int32
  field :days, 2, type: :int32
  field :nanoseconds, 3, type: :int64
end

defmodule Greptime.V1.Decimal128 do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :hi, 1, type: :int64
  field :lo, 2, type: :int64
end

defmodule Greptime.V1.ColumnDataTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :type_ext, 0

  field :decimal_type, 1,
    type: Greptime.V1.DecimalTypeExtension,
    json_name: "decimalType",
    oneof: 0

  field :json_type, 2,
    type: Greptime.V1.JsonTypeExtension,
    json_name: "jsonType",
    enum: true,
    oneof: 0

  field :vector_type, 3, type: Greptime.V1.VectorTypeExtension, json_name: "vectorType", oneof: 0
end

defmodule Greptime.V1.DecimalTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :precision, 1, type: :int32
  field :scale, 2, type: :int32
end

defmodule Greptime.V1.VectorTypeExtension do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :dim, 1, type: :uint32
end

defmodule Greptime.V1.ColumnOptions.OptionsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.ColumnOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :options, 1, repeated: true, type: Greptime.V1.ColumnOptions.OptionsEntry, map: true
end
