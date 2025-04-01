defmodule Greptimex.MixProject do
  use Mix.Project

  def project do
    [
      app: :greptimex,
      version: "0.1.3",
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
      {:protobuf, "~> 0.14.1"},
      {:grpc, "~> 0.9"},
      {:conn_grpc, "~> 0.2"},
      {:castore, "~> 1.0", only: :dev}
    ]
  end
end
