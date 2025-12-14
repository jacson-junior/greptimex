defmodule Greptimex.MixProject do
  use Mix.Project

  def project do
    [
      app: :greptimex,
      version: "0.2.4",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      name: "Greptimex",
      source_url: "https://github.com/jacson-junior/greptimex"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Greptimex.Application, []}
    ]
  end

  defp deps do
    [
      {:grpc, "~> 0.11"},
      {:protobuf, "~> 0.15"},
      {:conn_grpc, "~> 0.3"},
      {:telemetry, "~> 1.0"},
      {:castore, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Elixir client for GreptimeDB using gRPC"
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/jacson-junior/greptimex"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
