defmodule Greptimex.Greptime.V1.CommentObjectType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "greptime.v1.CommentObjectType",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :TABLE, 0
  field :COLUMN, 1
  field :FLOW, 2
end
