defmodule NflWeb.PlayerController do
  use NflWeb, :controller
  use Params

  alias Nfl.Players

  action_fallback NflWeb.FallbackController


  defparams players %{
    filter: [field: :string, default: ""],
    page_number: [field: :integer, default: 1],
    page_size: [field: :integer, default: 10],
  }

  def index(conn, params) do
    params =
      params
      |> players
      |> Params.data

    players =
      Players.list()
      |> Players.filter(params.filter)
      |> Players.paginate(params.page_number, params.page_size)
      |> Players.collect()

    render(conn, "index.json", players: players)
  end
end
