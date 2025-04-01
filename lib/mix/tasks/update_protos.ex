defmodule Mix.Tasks.UpdateProtos do
  use Mix.Task

  @base_url "https://raw.githubusercontent.com/GreptimeTeam/greptime-proto/main/proto/greptime/v1/"
  @files [
    "column.proto",
    "common.proto",
    "database.proto",
    "ddl.proto",
    "health.proto",
    "row.proto",
    "prom.proto"
  ]

  require Logger

  def run(_) do
    Mix.ensure_application!(:inets)
    Mix.ensure_application!(:ssl)

    File.mkdir_p!("greptime/v1")

    @files
    |> Enum.each(fn file ->
      url = @base_url <> file
      target_path = Path.join("greptime/v1", file)

      Mix.shell().info("Downloading #{url} to #{target_path}...")

      case do_http_request(url) do
        {:ok, body} ->
          File.write!(target_path, body)
          Mix.shell().info("Downloaded file: #{target_path}")

        {:error, reason} ->
          Mix.shell().error("Failed to download file: #{inspect(reason)}")
      end
    end)

    Mix.shell().info("Proto files update complete!")
  end

  # https://github.com/nerves-flutter/nerves_flutter_support/blob/47be2a11d8e4cfc2fa8f1ae6567000674ef123dc/lib/downloader.ex#L90
  defp do_http_request(url) do
    url = String.to_charlist(url)
    Logger.debug("Making HTTP/HTTPS request for URL: #{url}")

    # Ensure we start required applications for downloading a file
    {:ok, _} = Application.ensure_all_started(:inets)
    {:ok, _} = Application.ensure_all_started(:ssl)

    # Proxy configuration (if set in user's environment)
    http_proxy_config = System.get_env("HTTP_PROXY")
    https_proxy_config = System.get_env("HTTPS_PROXY")

    if not is_nil(http_proxy_config) do
      http_config = URI.parse(http_proxy_config)

      :httpc.set_options([
        {:proxy, {{String.to_charlist(http_config.host), http_config.port}, []}}
      ])

      Logger.info("Using HTTP proxy config: #{http_proxy_config}")
    end

    if not is_nil(https_proxy_config) do
      https_config = URI.parse(https_proxy_config)

      :httpc.set_options([
        {:https_proxy, {{String.to_charlist(https_config.host), https_config.port}, []}}
      ])

      Logger.info("Using HTTPS proxy config: #{https_proxy_config}")
    end

    # https://erlef.github.io/security-wg/secure_coding_and_deployment_hardening/inets
    cacertfile = System.get_env("HEX_CACERTS_PATH", CAStore.file_path())

    options = [
      ssl: [
        verify: :verify_peer,
        cacertfile: cacertfile |> String.to_charlist(),
        depth: 3,
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ]
      ]
    ]

    resp = :httpc.request(:get, {url, []}, options, body_format: :binary)

    case resp do
      {:ok, {{_, 200, _}, _, body}} ->
        {:ok, body}

      bad_result ->
        Logger.error("Failed to run HTTP/HTTPS request #{url} \n\t #{inspect(bad_result)}")
        {:error, bad_result}
    end
  end
end
