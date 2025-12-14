defmodule Greptimex.Greptime.V1.AddColumn do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :column_def, 1, type: Greptimex.Greptime.V1.ColumnDef, json_name: "columnDef"
  field :location, 3, type: Greptimex.Greptime.V1.AddColumnLocation
  field :add_if_not_exists, 4, type: :bool, json_name: "addIfNotExists"
end
