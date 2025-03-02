defmodule ElixirMockTestDemoWeb.WeatherControllerTest do
  use ElixirMockTestDemoWeb.ConnCase, async: true
  use ElixirMockTestDemoWeb.MockCase

  alias ElixirMockTestDemo.WeatherMock

  describe "get weather" do
    test "success", %{conn: conn} do
      response = %{"code" => "9", "temperature" => "13", "text" => "阴"}

      WeatherMock
      |> expect(:get_forecast, fn "beijing" ->
        {:ok, response}
      end)

      conn = get(conn, ~p"/api/weather/beijing")

      assert ^response = json_response(conn, 200)
    end

    test "city not found", %{conn: conn} do
      WeatherMock
      |> expect(:get_forecast, fn "beijing1" ->
        {:error, %Req.Response{status: 404}}
      end)

      conn = get(conn, ~p"/api/weather/beijing1")

      assert json_response(conn, 404)
    end
  end
end
