defmodule Greptimex.Ingester do
  alias Greptimex.Point

  def start_link(opts) do
    ConnGRPC.Channel.start_link(opts)
  end

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
    timestamp_column = Keyword.get(opts, :timestamp_column, "timestamp")
    timestamp_type = Keyword.get(opts, :timestamp_type, :TIMESTAMP_MILLISECOND)

    with {:ok, channel} <- ConnGRPC.Channel.get(channel) do
      columns = Point.to_columns(points, timestamp_column, timestamp_type)

      header = %Greptime.V1.RequestHeader{
        catalog: "greptime",
        dbname: opts[:database] || "public",
        schema: opts[:schema] || nil,
        timezone: opts[:timezone] || nil
      }

      insert_request = %Greptime.V1.InsertRequest{
        table_name: table_name,
        columns: columns,
        row_count: if(Enum.empty?(points), do: 0, else: length(points))
      }

      request =
        %Greptime.V1.GreptimeRequest{
          header: header,
          request: {:inserts, %Greptime.V1.InsertRequests{inserts: [insert_request]}}
        }

      Greptime.V1.GreptimeDatabase.Stub.handle(channel, request)
    end
  end

  def write(channel, table_name, point, opts) do
    write(channel, table_name, [point], opts)
  end
end
