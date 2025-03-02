defmodule ElixirMockTestDemoWeb.WeatherController do
  use ElixirMockTestDemoWeb, :controller
  use Goal

  defparams :show do
    required :city, :string
  end

  def show(conn, unsafe_params) do
    with {:ok, params} <- validate(:show, unsafe_params),
         {:ok, weather} <- ElixirMockTestDemo.Weather.get_forecast(params.city) do
      json(conn, weather)
    else
      {:error, :api_error} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{errors: %{detail: "Internal Server Error"}})

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end)

        conn
        |> put_status(:bad_request)
        |> json(%{errors: errors})
    end
  end
end
