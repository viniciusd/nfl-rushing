defmodule NflWeb.PlayerView do
  use NflWeb, :view
  alias NflWeb.PlayerView

  defp update_query_params(url, params) do
    url
    |> URI.merge("?" <> (params |> URI.encode_query))
    |> to_string()
  end

  defp build_links(url, %{page_number: 1} = params) do
      %{
        self: %{ href: update_query_params(url, params)},
        next: %{ href: update_query_params(url, %{params | page_number: params.page_number+1})},
      }
  end

  defp build_links(url, params) do
      %{
        prev: %{ href: update_query_params(url, %{params | page_number: params.page_number-1})},
        self: %{ href: update_query_params(url, params)},
        next: %{ href: update_query_params(url, %{params | page_number: params.page_number+1})},
      }
  end

  def render("index.json", %{players: players, url: url, params: params}) do
    %{
      data: render_many(players, PlayerView, "player.json"),
      _links: build_links(url, params),
    }
  end

  def render("player.json", %{player: player}) do
    player
  end
end
