defmodule NflWeb.PlayerController do
  use NflWeb, :controller
  use Params

  alias Nfl.Players

  action_fallback NflWeb.FallbackController

  defparams(
    players(%{
      filter: [field: :string, default: ""],
      page_number: [field: :integer, default: 1],
      page_size: [field: :integer, default: 10]
    })
  )

  def index(conn, params) do
    params =
      params
      |> players
      |> Params.to_map()

    players =
      Players.list()
      |> Players.filter(Map.get(params, :filter))
      |> Players.paginate(Map.get(params, :page_number), Map.get(params, :page_size))
      |> Players.collect()

    render(conn, "index.json", players: players, url: Plug.Conn.request_url(conn), params: params)
  end
end
