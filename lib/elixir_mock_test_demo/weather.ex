defmodule ElixirMockTestDemo.Weather do
  require Logger
  @weather_uri "https://api.seniverse.com/v3/weather/now.json"
  @ttl 300

  @spec get_forecast(String.t()) :: {:ok, map()} | {:error, :api_error}
  def get_forecast(city) do
    timestamp = DateTime.utc_now() |> DateTime.to_unix()
    query = %{ts: timestamp, ttl: @ttl, uid: public_key(), sig: create_sig(), location: city}

    case Req.post(@weather_uri, params: query) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body["results"] |> hd() |> then(fn x -> x["now"] end)}

      error ->
        Logger.error("get forecast error: #{inspect(error)}")
        {:error, :api_error}
    end
  end

  defp create_sig do
    timestamp = DateTime.utc_now() |> DateTime.to_unix()

    :hmac
    |> :crypto.mac(:sha, private_key(), "ts=#{timestamp}&ttl=#{@ttl}&uid=#{public_key()}")
    |> Base.encode64()
  end

  defp public_key, do: config() |> Keyword.fetch!(:public_key)
  defp private_key, do: config() |> Keyword.fetch!(:private_key)
  defp config, do: Application.fetch_env!(:elixir_mock_test_demo, :seniverse)
end
