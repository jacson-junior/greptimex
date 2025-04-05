defmodule Greptimex.Ingester do
  alias Greptimex.Point

  defdelegate start_link(opts), to: ConnGRPC.Channel
  defdelegate child_spec(opts), to: ConnGRPC.Channel

  @doc """
  Write point(s) to GreptimeDB

  Example:

    iex> write(pid, "public", [%Greptimex.Point{tags: %{"host" => "server-1", "region" => "us-east"}, fields: %{"cpu_usage" => 78.5, "memory_usage" => 45.2}, timestamp: System.os_time(:millisecond)}])
    {:ok, %Greptime.V1.InsertResponse{}}

  Options:
  - database: The database name to write to (default: "public")
  - schema: The schema name to write to (default: nil)
  - timezone: The timezone to use for the timestamp (default: nil)
  - timestamp_column: The name of the timestamp column (default: "timestamp")
  - timestamp_type: The data type for the timestamp (:TIMESTAMP_MILLISECOND, :TIMESTAMP_SECOND, etc.) (default: :TIMESTAMP_MILLISECOND)
  """
  def write(channel, table_name, points, opts \\ [])

  def write(channel, table_name, points, opts) when is_list(points) do
    with {:ok, channel} <- ConnGRPC.Channel.get(channel) do
      insert = insert_request(table_name, points, opts)

      Greptime.V1.GreptimeDatabase.Stub.handle(
        channel,
        %Greptime.V1.GreptimeRequest{
          header: header(opts),
          request: {:inserts, %Greptime.V1.InsertRequests{inserts: [insert]}}
        }
        |> dbg
      )
    end
  end

  def write(channel, table_name, point, opts) do
    write(channel, table_name, [point], opts)
  end

  def write_batch(channel, batch, opts \\ []) when is_list(batch) do
    inserts =
      batch
      |> Enum.map(fn %{table: table, points: points} ->
        insert_request(table, points, opts)
      end)

    with {:ok, channel} <- ConnGRPC.Channel.get(channel) do
      Greptime.V1.GreptimeDatabase.Stub.handle(channel, %Greptime.V1.GreptimeRequest{
        header: header(opts),
        request: {:inserts, %Greptime.V1.InsertRequests{inserts: inserts}}
      })
    end
  end

  defp header(opts) do
    %Greptime.V1.RequestHeader{
      catalog: "greptime",
      dbname: opts[:database] || "public",
      schema: opts[:schema] || nil,
      timezone: opts[:timezone] || nil,
      authorization: opts[:auth] |> maybe_add_auth()
    }
  end

  defp insert_request(table, points, opts) do
    timestamp_column = Keyword.get(opts, :timestamp_column, "timestamp")
    timestamp_type = Keyword.get(opts, :timestamp_type, :TIMESTAMP_MILLISECOND)

    columns = Point.to_columns(points, timestamp_column, timestamp_type)

    %Greptime.V1.InsertRequest{
      table_name: table,
      columns: columns,
      row_count: length(points)
    }
  end

  defp maybe_add_auth({:basic, {username, password}}) do
    %Greptime.V1.AuthHeader{
      auth_scheme:
        {:basic,
         %Greptime.V1.Basic{
           username: username,
           password: password
         }}
    }
  end

  defp maybe_add_auth(nil), do: nil
end
