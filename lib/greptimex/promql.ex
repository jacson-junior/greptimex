defmodule Greptimex.Promql do
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
    start_time = DateTime.to_unix(start_time)
    end_time = DateTime.to_unix(end_time)

    query_range(channel, query, start_time, end_time, step, lookback, opts)
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
    prom_query =
      %V1.PromRangeQuery{
        query: query,
        start: to_string(start_time),
        end: to_string(end_time),
        step: step,
        lookback: lookback
      }

    case V1.PrometheusGateway.Stub.handle(
           channel,
           %V1.PromqlRequest{
             header: Connection.header(opts[:header]),
             promql: {:range_query, prom_query}
           }
         ) do
      {:ok,
       %{
         header: %{status: %{status_code: 0}},
         body: body
       }} ->
        case JSON.decode!(body) do
          %{"status" => "error"} = response ->
            {:error, %{message: response["error"]}}

          %{"status" => "success"} = response ->
            {:ok, parse_matrix(response["data"])}
        end

      {:ok, %{header: %{status: %{status_code: status, err_msg: message}}}} ->
        {:error, %{status: status, message: message}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def query_instant(channel, query, %DateTime{} = time, lookback, opts) do
    time = DateTime.to_unix(time)
    query_instant(channel, query, time, lookback, opts)
  end

  def query_instant(channel, query, time, lookback, opts) when is_integer(time) do
    prom_query =
      %V1.PromInstantQuery{
        query: query,
        time: to_string(time),
        lookback: lookback
      }

    case V1.PrometheusGateway.Stub.handle(
           channel,
           %V1.PromqlRequest{
             header: Connection.header(opts[:header]),
             promql: {:instant_query, prom_query}
           }
         ) do
      {:ok,
       %{
         header: %{status: %{status_code: 0}},
         body: body
       }} ->
        case JSON.decode!(body) do
          %{"status" => "error"} = response ->
            {:error, %{message: response["error"]}}

          %{"status" => "success"} = response ->
            {:ok, parse_vector(response["data"])}
        end

      {:ok, %{header: %{status: %{status_code: status, err_msg: message}}}} ->
        {:error, %{status: status, message: message}}

      {:error, reason} ->
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
end
