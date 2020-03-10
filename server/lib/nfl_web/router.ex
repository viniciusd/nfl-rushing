defmodule NflWeb.Router do
  use NflWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NflWeb do
    pipe_through :api
  end
end
