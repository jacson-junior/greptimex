defmodule Greptimex.Connection do
  @moduledoc """
  Defines a GreptimeDB connection module.

  When used, it sets up a connection pool and provides functions for inserting data
  and querying with PromQL.

  ## Configuration

  * `:pool` - Connection pool options. For all options, see `ConnGRPC.Pool.start_link/1`
  * `:header` - Default header options (catalog, database, schema, timezone, auth)
  * `:defaults` - Default options for insert operations (timestamp_name, timestamp_datatype)
  * `:otp_app` - (optional) The OTP application to fetch configuration from. If provided, the module will read its configuration
    from the application's environment using the module name as the key.

  ## Example

      defmodule MyApp.Greptimex do
        use Greptimex.Connection,
          pool: [
            pool_size: 5,
            channel: [address: "localhost:50051", opts: []]
          ],
          header: [
            catalog: "greptime",
            database: "public"
          ]
      end
  """

  alias Greptimex.Greptime.V1

  @type t :: module

  @doc """
  Inserts rows into GreptimeDB. Supports single/multiple rows and single/multiple tables.

  ## Examples

      # Single row, single table
      MyApp.Greptimex.insert({"metrics", %{tags: %{host: "server1"}, fields: %{cpu: 0.8}, timestamp: ~U[2025-01-01 00:00:00Z]}})
      {:ok, 1}

      # Multiple rows, single table
      MyApp.Greptimex.insert({"metrics", [
        %{tags: %{host: "server1"}, fields: %{cpu: 0.8}, timestamp: ~U[2025-01-01 00:00:00Z]},
        %{tags: %{host: "server2"}, fields: %{cpu: 0.5}, timestamp: ~U[2025-01-01 00:00:01Z]}
      ]})
      {:ok, 2}

      # Multiple rows, multiple tables
      MyApp.Greptimex.insert([
        {"metrics", [
          %{tags: %{host: "server1"}, fields: %{cpu: 0.8}, timestamp: ~U[2025-01-01 00:00:00Z]},
          %{tags: %{host: "server2"}, fields: %{cpu: 0.5}, timestamp: ~U[2025-01-01 00:00:01Z]}
        ]},
        {"logs", [
          %{tags: %{level: "info"}, fields: %{message: "test"}, timestamp: ~U[2025-01-01 00:00:00Z]},
          %{tags: %{level: "error"}, fields: %{message: "failed"}, timestamp: ~U[2025-01-01 00:00:01Z]}
        ]}
      ])
      {:ok, 4}
  """
  @callback insert(rows :: term, opts :: Keyword.t()) :: {:ok, non_neg_integer} | {:error, term}

  @doc """
  Executes a PromQL range query over a time period.

  ## Examples

      MyApp.Greptimex.query_range("up", ~U[2025-01-01 00:00:00Z], ~U[2025-01-01 01:00:00Z], "5m")
      {:ok, [%{metric: %{"__name__" => "up"}, values: [...]}]}
  """
  @callback query_range(
              query :: String.t(),
              start_time :: DateTime.t() | integer,
              end_time :: DateTime.t() | integer,
              step :: String.t(),
              lookback :: String.t(),
              opts :: Keyword.t()
            ) :: {:ok, list} | {:error, term}

  @doc """
  Executes a PromQL instant query at a specific time.

  ## Examples

      MyApp.Greptimex.query_instant("up")
      {:ok, [%{metric: %{"__name__" => "up"}, value: {~U[2025-01-01 12:00:00Z], 1.0}}]}

      MyApp.Greptimex.query_instant("up{job='api'}", ~U[2025-01-01 12:00:00Z])
      {:ok, [%{metric: %{"__name__" => "up", "job" => "api"}, value: {~U[2025-01-01 12:00:00Z], 1.0}}]}
  """
  @callback query_instant(
              query :: String.t(),
              time :: DateTime.t() | integer,
              lookback :: String.t(),
              opts :: Keyword.t()
            ) :: {:ok, list} | {:error, term}

  defmacro __using__(use_opts) do
    otp_app = use_opts[:otp_app]

    quote bind_quoted: [use_opts: use_opts, otp_app: otp_app] do
      @behaviour Greptimex.Connection

      @use_opts (if(otp_app) do
                   Application.compile_env!(otp_app, __MODULE__)
                 else
                   use_opts
                 end)

      use ConnGRPC.Pool, @use_opts[:pool]

      alias Greptimex.Insert
      alias Greptimex.Promql

      @header_opts Keyword.merge(
                     [catalog: "greptime", database: "public"],
                     @use_opts[:header] || []
                   )
      @default_opts Keyword.merge(
                      [
                        timestamp_name: "greptime_timestamp",
                        timestamp_datatype: :TIMESTAMP_MILLISECOND
                      ],
                      @use_opts[:defaults] || []
                    )

      @impl true
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

      @impl true
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

      @impl true
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
