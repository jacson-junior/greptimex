defmodule Greptimex.Greptime.V1.PromqlResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :header, 1, type: Greptimex.Greptime.V1.ResponseHeader
  field :body, 2, type: :bytes
end
