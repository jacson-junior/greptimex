defmodule Greptimex.Greptime.V1.JsonValue do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :value, 0

  field :boolean, 1, type: :bool, oneof: 0
  field :int, 2, type: :int64, oneof: 0
  field :uint, 3, type: :uint64, oneof: 0
  field :float, 4, type: :double, oneof: 0
  field :str, 5, type: :string, oneof: 0
  field :array, 6, type: Greptimex.Greptime.V1.JsonList, oneof: 0
  field :object, 7, type: Greptimex.Greptime.V1.JsonObject, oneof: 0
end
