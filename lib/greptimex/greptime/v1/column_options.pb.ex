defmodule Greptimex.Greptime.V1.ColumnOptions do
  @moduledoc """
  Additional options for the column.
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :options, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.ColumnOptions.OptionsEntry,
    map: true
end
