# Greptimex

Elixir client for [GreptimeDB](https://greptime.com/) with gRPC support.

## Installation

```elixir
def deps do
  [
    {:greptimex, "~> 0.2"}
  ]
end
```

## Usage

Define a connection module:

```elixir
defmodule MyApp.Greptime do
  use Greptimex.Connection,
    pool: [
      pool_size: 5,
      channel: [address: "localhost:4001", opts: []]
    ],
    header: [
      catalog: "greptime",
      database: "public"
    ]
end
```

Or with config:

```elixir
# config/config.exs
config :my_app, MyApp.Greptime,
  pool: [
    pool_size: 5,
    channel: [address: "localhost:4001", opts: []]
  ],
  header: [
    catalog: "greptime",
    database: "public"
  ]

# lib/my_app/greptime.ex
defmodule MyApp.Greptime do
  use Greptimex.Connection, otp_app: :my_app
end
```

### Insert Data

Single row:

```elixir
MyApp.Greptime.insert({"metrics", %{
  tags: %{host: "server1", region: "us-west"},
  fields: %{cpu: 0.8, memory: 1024},
  timestamp: ~U[2025-01-01 00:00:00Z]
}})
# {:ok, 1}
```

Multiple rows:

```elixir
MyApp.Greptime.insert({"metrics", [
  %{tags: %{host: "server1"}, fields: %{cpu: 0.8}, timestamp: ~U[2025-01-01 00:00:00Z]},
  %{tags: %{host: "server2"}, fields: %{cpu: 0.5}, timestamp: ~U[2025-01-01 00:00:01Z]}
]})
# {:ok, 2}
```

Multiple tables:

```elixir
MyApp.Greptime.insert([
  {"metrics", [...]},
  {"logs", [...]}
])
```

### PromQL Queries

Instant query:

```elixir
MyApp.Greptime.query_instant("up{job='api'}")
# {:ok, [%{metric: %{"__name__" => "up", "job" => "api"}, value: {~U[...], 1.0}}]}
```

Range query:

```elixir
MyApp.Greptime.query_range(
  "cpu_usage",
  ~U[2025-01-01 00:00:00Z],
  ~U[2025-01-01 01:00:00Z],
  "5m"
)
# {:ok, [%{metric: %{...}, values: [{~U[...], 0.8}, ...]}]}
```

## Telemetry

Events emitted:

- `[:greptimex, :insert, :start | :success | :failure]`
- `[:greptimex, :query_instant, :start | :success | :failure]`
- `[:greptimex, :query_range, :start | :success | :failure]`
