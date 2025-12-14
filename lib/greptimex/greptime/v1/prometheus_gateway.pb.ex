defmodule Greptimex.Greptime.V1.PrometheusGateway.Service do
  @moduledoc """
  PrometheusGateway behaves absolutely the same as Prometheus HTTP API
  """

  use GRPC.Service, name: "greptime.v1.PrometheusGateway", protoc_gen_elixir_version: "0.15.0"

  rpc :Handle, Greptimex.Greptime.V1.PromqlRequest, Greptimex.Greptime.V1.PromqlResponse
end

defmodule Greptimex.Greptime.V1.PrometheusGateway.Stub do
  use GRPC.Stub, service: Greptimex.Greptime.V1.PrometheusGateway.Service
end
