defmodule Greptime.V1.HealthCheckRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3
end

defmodule Greptime.V1.HealthCheckResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3
end

defmodule Greptime.V1.HealthCheck.Service do
  @moduledoc false

  use GRPC.Service, name: "greptime.v1.HealthCheck", protoc_gen_elixir_version: "0.14.0"

  rpc :HealthCheck, Greptime.V1.HealthCheckRequest, Greptime.V1.HealthCheckResponse
end

defmodule Greptime.V1.HealthCheck.Stub do
  @moduledoc false

  use GRPC.Stub, service: Greptime.V1.HealthCheck.Service
end
