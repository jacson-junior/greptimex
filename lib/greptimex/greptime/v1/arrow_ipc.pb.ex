defmodule Greptimex.Greptime.V1.ArrowIpc do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ArrowIpc",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :schema, 1, type: :bytes
  field :data_header, 2, type: :bytes, json_name: "dataHeader"
  field :payload, 3, type: :bytes
end
