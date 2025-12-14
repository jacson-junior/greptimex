defmodule Greptimex.Connection do
  alias Greptimex.Greptime.V1

  defmacro __using__(opts) do
    quote do
      use ConnGRPC.Pool,
          unquote(opts[:pool])

      alias Greptimex.Insert
      alias Greptimex.Promql

      @header_opts Keyword.merge(
                     [catalog: "greptime", database: "public"],
                     unquote(opts[:header] || [])
                   )
      @default_opts Keyword.merge(
                      [
                        timestamp_name: "greptime_timestamp",
                        timestamp_datatype: :TIMESTAMP_MILLISECOND
                      ],
                      unquote(opts[:defaults] || [])
                    )

      def insert(rows, opts \\ [])

      def insert(rows, opts) when is_list(rows) do
        with {:ok, channel} <- get_channel() do
          header_opts = Keyword.merge(@header_opts, opts[:header] || [])
          opts = Keyword.put(opts, :header, header_opts)

          Insert.handle(channel, rows, Keyword.merge(@default_opts, opts[:defaults] || []))
        end
      end

      def insert(row, opts) do
        with {:ok, channel} <- get_channel() do
          header_opts = Keyword.merge(@header_opts, opts[:header] || [])
          opts = Keyword.put(opts, :header, header_opts)

          Insert.handle(channel, [row], Keyword.merge(@default_opts, opts[:defaults] || []))
        end
      end

      def query_range(query, start_time, end_time, step, lookback \\ "5m", opts \\ [])

      def query_range(query, start_time, end_time, step, lookback, opts) do
        with {:ok, channel} <- get_channel() do
          header_opts = Keyword.merge(@header_opts, opts[:header] || [])
          opts = Keyword.put(opts, :header, header_opts)

          Promql.query_range(
            channel,
            query,
            start_time,
            end_time,
            step,
            lookback,
            opts
          )
        end
      end

      def query_instant(query, time \\ DateTime.utc_now(), lookback \\ "5m", opts \\ []) do
        with {:ok, channel} <- get_channel() do
          header_opts = Keyword.merge(@header_opts, opts[:header] || [])
          opts = Keyword.put(opts, :header, header_opts)

          Promql.query_instant(
            channel,
            query,
            time,
            lookback,
            opts
          )
        end
      end
    end
  end

  def header(opts) do
    %V1.RequestHeader{
      catalog: opts[:catalog],
      dbname: opts[:dbname],
      schema: opts[:schema],
      timezone: opts[:timezone],
      authorization: opts[:auth]
    }
  end
end
