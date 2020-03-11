defmodule NflWeb.PlayerController do
  use NflWeb, :controller
  use Params

  alias Nfl.Players

  action_fallback NflWeb.FallbackController

  defparams(
    players(%{
      filter: [field: :string, default: ""],
      sort: :string,
      order: :string,
      page_number: [field: :integer, default: 1],
      page_size: [field: :integer, default: 10],
    })
  )

  def index(conn, params) do
    params =
      params
      |> players
      |> Params.to_map()

    IO.inspect(params)

    players =
      Players.list()
      |> Players.filter(Map.get(params, :filter))
      |> Players.sort(Map.get(params, :sort), Map.get(params, :order))
      |> Players.paginate(Map.get(params, :page_number), Map.get(params, :page_size))
      |> Players.collect()

    render(conn, "index.json", players: players, url: Plug.Conn.request_url(conn), params: params)
  end
end
