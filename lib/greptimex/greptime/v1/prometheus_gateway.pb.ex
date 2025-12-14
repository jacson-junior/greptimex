defmodule Greptimex.Greptime.V1.PrometheusGateway.Service do
  @moduledoc false

  use GRPC.Service, name: "greptime.v1.PrometheusGateway", protoc_gen_elixir_version: "0.15.0"

  rpc :Handle, Greptimex.Greptime.V1.PromqlRequest, Greptimex.Greptime.V1.PromqlResponse
end

defmodule Greptimex.Greptime.V1.PrometheusGateway.Stub do
  @moduledoc false

  use GRPC.Stub, service: Greptimex.Greptime.V1.PrometheusGateway.Service
end
