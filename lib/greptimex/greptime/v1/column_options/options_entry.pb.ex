defmodule Greptimex.Greptime.V1.ColumnOptions.OptionsEntry do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.ColumnOptions.OptionsEntry",
    map: true,
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end
