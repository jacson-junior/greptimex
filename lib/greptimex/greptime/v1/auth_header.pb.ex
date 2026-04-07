defmodule Greptimex.Greptime.V1.AuthHeader do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.AuthHeader",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  oneof :auth_scheme, 0

  field :basic, 1, type: Greptimex.Greptime.V1.Basic, oneof: 0
  field :token, 2, type: Greptimex.Greptime.V1.Token, oneof: 0
end
