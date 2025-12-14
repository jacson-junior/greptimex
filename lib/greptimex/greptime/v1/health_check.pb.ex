defmodule Greptimex.Greptime.V1.HealthCheck.Service do
  @moduledoc false

  use GRPC.Service, name: "greptime.v1.HealthCheck", protoc_gen_elixir_version: "0.15.0"

  rpc :HealthCheck,
      Greptimex.Greptime.V1.HealthCheckRequest,
      Greptimex.Greptime.V1.HealthCheckResponse
end

defmodule Greptimex.Greptime.V1.HealthCheck.Stub do
  @moduledoc false

  use GRPC.Stub, service: Greptimex.Greptime.V1.HealthCheck.Service
end
