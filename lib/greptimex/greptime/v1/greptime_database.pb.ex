defmodule Greptimex.Greptime.V1.GreptimeDatabase.Service do
  @moduledoc false

  use GRPC.Service, name: "greptime.v1.GreptimeDatabase", protoc_gen_elixir_version: "0.15.0"

  rpc :Handle, Greptimex.Greptime.V1.GreptimeRequest, Greptimex.Greptime.V1.GreptimeResponse

  rpc :HandleRequests,
      stream(Greptimex.Greptime.V1.GreptimeRequest),
      Greptimex.Greptime.V1.GreptimeResponse
end

defmodule Greptimex.Greptime.V1.GreptimeDatabase.Stub do
  @moduledoc false

  use GRPC.Stub, service: Greptimex.Greptime.V1.GreptimeDatabase.Service
end
