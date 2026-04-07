defmodule Greptimex.Greptime.V1.SnapshotSequences.SstMinSequencesEntry do
  @moduledoc false

  use Protobuf,
    full_name: "greptime.v1.SnapshotSequences.SstMinSequencesEntry",
    map: true,
    protoc_gen_elixir_version: "0.16.0",
    syntax: :proto3

  field :key, 1, type: :uint64
  field :value, 2, type: :uint64
end
