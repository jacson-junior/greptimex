defmodule Greptimex.Greptime.V1.WebhookOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :url, 1, type: :string
  field :opts, 2, repeated: true, type: Greptimex.Greptime.V1.WebhookOptions.OptsEntry, map: true
end
