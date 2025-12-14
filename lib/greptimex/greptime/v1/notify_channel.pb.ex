defmodule Greptimex.Greptime.V1.NotifyChannel do
  @moduledoc """
  The notification channel for trigger.
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  oneof :channel_type, 0

  field :name, 1, type: :string
  field :webhook, 2, type: Greptimex.Greptime.V1.WebhookOptions, oneof: 0
end
