defmodule NflWeb.PlayerController do
  use NflWeb, :controller

  alias Nfl.Players
  alias Nfl.Accounts.Player

  action_fallback NflWeb.FallbackController

  def index(conn, _params) do
    players = Accounts.list_players()
    render(conn, "index.json", players: players)
  end
end
