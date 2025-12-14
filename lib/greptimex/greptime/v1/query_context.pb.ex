defmodule Greptimex.Greptime.V1.QueryContext do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :current_catalog, 1, type: :string, json_name: "currentCatalog"
  field :current_schema, 2, type: :string, json_name: "currentSchema"
  field :timezone, 4, type: :string

  field :extensions, 5,
    repeated: true,
    type: Greptimex.Greptime.V1.QueryContext.ExtensionsEntry,
    map: true

  field :channel, 6, type: :uint32

  field :snapshot_seqs, 7,
    type: Greptimex.Greptime.V1.SnapshotSequences,
    json_name: "snapshotSeqs"

  field :explain, 8, type: Greptimex.Greptime.V1.ExplainOptions
end
