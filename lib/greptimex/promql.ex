defmodule Greptimex.Promql do
  @moduledoc false

  alias Greptimex.Connection
  alias Greptimex.Greptime.V1

  def query_range(
        channel,
        query,
        %DateTime{} = start_time,
        %DateTime{} = end_time,
        step,
        lookback,
        opts
      ) do
    start_time_unix = DateTime.to_unix(start_time)
    end_time_unix = DateTime.to_unix(end_time)

    query_range(channel, query, start_time_unix, end_time_unix, step, lookback, opts)
  end

  def query_range(
        channel,
        query,
        start_time,
        end_time,
        step,
        lookback,
        opts
      )
      when is_integer(start_time) and is_integer(end_time) do
    start_monotonic = System.monotonic_time()
    metadata = %{query: query, start_time: start_time, end_time: end_time, step: step}

    emit_start(:query_range, metadata)

    prom_query =
      %V1.PromRangeQuery{
        query: query,
        start: to_string(start_time),
        end: to_string(end_time),
        step: step,
        lookback: lookback
      }

    result =
      V1.PrometheusGateway.Stub.handle(
        channel,
        %V1.PromqlRequest{
          header: Connection.header(opts[:header]),
          promql: {:range_query, prom_query}
        }
      )

    duration = System.monotonic_time() - start_monotonic

    case result do
      {:ok,
       %{
         header: %{status: %{status_code: 0}},
         body: body
       }} ->
        case JSON.decode!(body) do
          %{"status" => "error"} = response ->
            error = %{message: response["error"]}
            emit_failure(:query_range, duration, :error, error, metadata)
            {:error, error}

          %{"status" => "success"} = response ->
            parsed = parse_matrix(response["data"])
            emit_success(:query_range, duration, length(parsed), metadata)
            {:ok, parsed}
        end

      {:ok, %{header: %{status: %{status_code: status, err_msg: message}}}} ->
        error = %{status: status, message: message}
        emit_failure(:query_range, duration, :error, error, metadata)
        {:error, error}

      {:error, reason} ->
        emit_failure(:query_range, duration, :error, reason, metadata)
        {:error, reason}
    end
  end

  def query_instant(channel, query, %DateTime{} = time, lookback, opts) do
    time_unix = DateTime.to_unix(time)
    query_instant(channel, query, time_unix, lookback, opts)
  end

  def query_instant(channel, query, time, lookback, opts) when is_integer(time) do
    start_monotonic = System.monotonic_time()
    metadata = %{query: query, time: time}

    emit_start(:query_instant, metadata)

    prom_query =
      %V1.PromInstantQuery{
        query: query,
        time: to_string(time),
        lookback: lookback
      }

    result =
      V1.PrometheusGateway.Stub.handle(
        channel,
        %V1.PromqlRequest{
          header: Connection.header(opts[:header]),
          promql: {:instant_query, prom_query}
        }
      )

    duration = System.monotonic_time() - start_monotonic

    case result do
      {:ok,
       %{
         header: %{status: %{status_code: 0}},
         body: body
       }} ->
        case JSON.decode!(body) do
          %{"status" => "error"} = response ->
            error = %{message: response["error"]}
            emit_failure(:query_instant, duration, :error, error, metadata)
            {:error, error}

          %{"status" => "success"} = response ->
            parsed = parse_vector(response["data"])
            emit_success(:query_instant, duration, length(parsed), metadata)
            {:ok, parsed}
        end

      {:ok, %{header: %{status: %{status_code: status, err_msg: message}}}} ->
        error = %{status: status, message: message}
        emit_failure(:query_instant, duration, :error, error, metadata)
        {:error, error}

      {:error, reason} ->
        emit_failure(:query_instant, duration, :error, reason, metadata)
        {:error, reason}
    end
  end

  defp parse_matrix(%{"resultType" => "matrix", "result" => result}) do
    Enum.map(result, fn %{"metric" => metric, "values" => values} ->
      %{
        metric: metric,
        values:
          Enum.map(values, fn [timestamp, value] ->
            microseconds = trunc(timestamp * 1_000_000)
            {value, _} = Float.parse(value)
            {DateTime.from_unix!(microseconds, :microsecond), value}
          end)
      }
    end)
  end

  defp parse_vector(%{"resultType" => "vector", "result" => result}) do
    Enum.map(result, fn %{"metric" => metric, "value" => [timestamp, value]} ->
      microseconds = trunc(timestamp * 1_000_000)
      {value, _} = Float.parse(value)

      %{
        metric: metric,
        value: {DateTime.from_unix!(microseconds, :microsecond), value}
      }
    end)
  end

  defp emit_start(event, metadata) do
    :telemetry.execute(
      [:greptimex, event, :start],
      %{system_time: System.system_time()},
      metadata
    )
  end

  defp emit_success(event, duration, result_count, metadata) do
    :telemetry.execute(
      [:greptimex, event, :success],
      %{duration: duration, result_count: result_count},
      metadata
    )
  end

  defp emit_failure(event, duration, kind, reason, metadata) do
    :telemetry.execute(
      [:greptimex, event, :failure],
      %{duration: duration},
      Map.merge(metadata, %{kind: kind, reason: reason})
    )
  end
end
