defmodule Greptimex.Greptime.V1.SetDefault do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.SetDefault",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :default_constraint, 2, type: :bytes, json_name: "defaultConstraint"
end
