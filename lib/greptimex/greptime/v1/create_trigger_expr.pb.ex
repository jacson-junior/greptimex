defmodule Greptimex.Greptime.V1.CreateTriggerExpr do
  @moduledoc """
  The create trigger expression.
  """

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :trigger_name, 2, type: :string, json_name: "triggerName"
  field :create_if_not_exists, 3, type: :bool, json_name: "createIfNotExists"
  field :sql, 4, type: :string
  field :channels, 5, repeated: true, type: Greptimex.Greptime.V1.NotifyChannel

  field :labels, 6,
    repeated: true,
    type: Greptimex.Greptime.V1.CreateTriggerExpr.LabelsEntry,
    map: true

  field :annotations, 7,
    repeated: true,
    type: Greptimex.Greptime.V1.CreateTriggerExpr.AnnotationsEntry,
    map: true

  field :interval, 8, type: Google.Protobuf.Duration
  field :raw_interval_expr, 9, type: :string, json_name: "rawIntervalExpr"
  field :for, 10, type: Google.Protobuf.Duration
  field :for_raw_expr, 11, type: :string, json_name: "forRawExpr"
  field :keep_firing_for, 12, type: Google.Protobuf.Duration, json_name: "keepFiringFor"
  field :keep_firing_for_raw_expr, 13, type: :string, json_name: "keepFiringForRawExpr"
end
