defmodule Greptime.V1.PromqlRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :promql, 0

  field :header, 1, type: Greptime.V1.RequestHeader
  field :instant_query, 2, type: Greptime.V1.PromInstantQuery, json_name: "instantQuery", oneof: 0
  field :range_query, 3, type: Greptime.V1.PromRangeQuery, json_name: "rangeQuery", oneof: 0
end

defmodule Greptime.V1.PromqlResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :header, 1, type: Greptime.V1.ResponseHeader
  field :body, 2, type: :bytes
end

defmodule Greptime.V1.PromInstantQuery do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :query, 1, type: :string
  field :time, 2, type: :string
  field :lookback, 3, type: :string
end

defmodule Greptime.V1.PromRangeQuery do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :query, 1, type: :string
  field :start, 2, type: :string
  field :end, 3, type: :string
  field :step, 4, type: :string
  field :lookback, 5, type: :string
end

defmodule Greptime.V1.PrometheusGateway.Service do
  @moduledoc false

  use GRPC.Service, name: "greptime.v1.PrometheusGateway", protoc_gen_elixir_version: "0.14.0"

  rpc :Handle, Greptime.V1.PromqlRequest, Greptime.V1.PromqlResponse
end

defmodule Greptime.V1.PrometheusGateway.Stub do
  @moduledoc false

  use GRPC.Stub, service: Greptime.V1.PrometheusGateway.Service
end
