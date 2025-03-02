defmodule ElixirMockTestDemoWeb.Router do
  use ElixirMockTestDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirMockTestDemoWeb do
    pipe_through :api

    get "/weather/:city", WeatherController, :show
  end
end
