defmodule Greptimex.Greptime.V1.ExpireAfter do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :value, 1, type: :int64
end
