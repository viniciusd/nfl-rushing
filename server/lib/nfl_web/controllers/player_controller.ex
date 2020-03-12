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
      page_size: [field: :integer, default: 10]
    })
  )

  def index(conn, %{"download" =>  _} = params) do
    params =
      params
      |> players
      |> Params.to_map()

    players =
      Players.list_all()
      |> Players.filter(Map.get(params, :filter))
      |> Players.sort(Map.get(params, :sort), Map.get(params, :order))
      |> Players.to_list()
      |> Players.collect()

    headers = Players.attributes()

    render(conn, "index.csv",
      headers: headers,
      players: players
    )
  end

  def index(conn, params) do
    params =
      params
      |> players
      |> Params.to_map()

    {page_count, players} =
      Players.list_all()
      |> Players.filter(Map.get(params, :filter))
      |> Players.sort(Map.get(params, :sort), Map.get(params, :order))
      |> Players.paginate(Map.get(params, :page_number), Map.get(params, :page_size))
      |> Players.collect()

    render(conn, "index.json",
      players: players,
      url: Plug.Conn.request_url(conn),
      params: params,
      page_count: page_count
    )
  end
end
