defmodule Greptimex.Greptime.V1.SnapshotSequences.SstMinSequencesEntry do
  use Protobuf, map: true, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :key, 1, type: :uint64
  field :value, 2, type: :uint64
end
