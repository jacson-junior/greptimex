defmodule Greptimex.Greptime.V1.SnapshotSequences do
  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :sst_min_sequences, 1,
    repeated: true,
    type: Greptimex.Greptime.V1.SnapshotSequences.SstMinSequencesEntry,
    json_name: "sstMinSequences",
    map: true

  field :snapshot_seqs, 7,
    repeated: true,
    type: Greptimex.Greptime.V1.SnapshotSequences.SnapshotSeqsEntry,
    json_name: "snapshotSeqs",
    map: true
end
