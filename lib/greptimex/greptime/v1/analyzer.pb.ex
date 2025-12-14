defmodule Greptimex.Greptime.V1.Analyzer do
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :ENGLISH, 0
  field :CHINESE, 1
end
