defmodule Greptimex.Greptime.V1.ResponseHeader do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :status, 1, type: Greptimex.Greptime.V1.Status
end
