defmodule Greptimex.Greptime.V1.Status do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.Status",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :status_code, 1, type: :uint32, json_name: "statusCode"
  field :err_msg, 2, type: :string, json_name: "errMsg"
end
