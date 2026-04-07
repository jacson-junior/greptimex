defmodule Greptimex.Greptime.V1.WebhookOptions do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.WebhookOptions",
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :url, 1, type: :string
  field :opts, 2, repeated: true, type: Greptimex.Greptime.V1.WebhookOptions.OptsEntry, map: true
end
