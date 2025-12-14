defmodule Greptimex.Greptime.V1.SetDefault do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :default_constraint, 2, type: :bytes, json_name: "defaultConstraint"
end
