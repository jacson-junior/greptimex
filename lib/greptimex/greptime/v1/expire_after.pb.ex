defmodule Greptimex.Greptime.V1.ExpireAfter do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ExpireAfter",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :value, 1, type: :int64
end
