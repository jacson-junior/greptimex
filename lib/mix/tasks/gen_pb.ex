defmodule Mix.Tasks.GenPb do
  use Mix.Task

  @shortdoc "Generates Elixir code from Protocol Buffers definitions"
  def run(_args) do
    Mix.shell().info("Generating Elixir code from Protocol Buffers...")

    proto_files = Path.wildcard("greptime/v1/*.proto")

    if proto_files == [] do
      Mix.shell().error("No proto files found in ./greptime/v1/")
      exit({:shutdown, 1})
    end

    {result, exit_code} =
      System.cmd(
        "protoc",
        ["--elixir_out=plugins=grpc:./lib" | proto_files],
        stderr_to_stdout: true
      )

    if exit_code == 0 do
      Mix.shell().info("Protocol Buffers generation completed successfully")
    else
      Mix.shell().error("Protocol Buffers generation failed: #{result}")
      exit({:shutdown, 1})
    end
  end
end
