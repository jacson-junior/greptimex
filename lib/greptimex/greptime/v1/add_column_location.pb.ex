defmodule Greptimex.Greptime.V1.AddColumnLocation do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :location_type, 1,
    type: Greptimex.Greptime.V1.AddColumnLocation.LocationType,
    json_name: "locationType",
    enum: true

  field :after_column_name, 2, type: :string, json_name: "afterColumnName"
end
