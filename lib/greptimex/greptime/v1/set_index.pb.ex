defmodule Greptimex.Greptime.V1.SetIndex do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :options, 0

  field :fulltext, 1, type: Greptimex.Greptime.V1.SetFulltext, oneof: 0
  field :inverted, 2, type: Greptimex.Greptime.V1.SetInverted, oneof: 0
  field :skipping, 3, type: Greptimex.Greptime.V1.SetSkipping, oneof: 0
end
