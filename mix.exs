defmodule Greptimex.MixProject do
  use Mix.Project

  def project do
    [
      app: :greptimex,
      version: "0.1.4",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:grpc, "~> 0.11"},
      {:protobuf, "~> 0.15"},
      {:conn_grpc, "~> 0.3"},
      {:telemetry, "~> 1.0"},
      {:castore, "~> 1.0", only: [:dev, :test]}
    ]
  end
end
