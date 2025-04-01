defmodule Greptimex do
  @moduledoc """
  Elixir client for GreptimeDB
  """

  defdelegate start_link(opts), to: Greptimex.Ingester
  defdelegate write(channel, table_name, points, opts \\ []), to: Greptimex.Ingester
  defdelegate write_batch(channel, batches, opts \\ []), to: Greptimex.Ingester

  defdelegate point(props), to: Greptimex.Point, as: :new
end
