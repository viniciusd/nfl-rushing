defmodule NflWeb.Router do
  use NflWeb, :router

  scope "/api", NflWeb do
    get "/players", PlayerController, :index
  end
end
