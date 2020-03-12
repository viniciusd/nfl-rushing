defmodule NflWeb.PlayerView do
  use NflWeb, :view
  alias NflWeb.PlayerView

  defp update_query_params(url, params) do
    url
    |> URI.merge("?" <> (params |> URI.encode_query()))
    |> to_string()
  end

  defp build_links(url, %{page_number: 1} = params, 1) do
    %{
      self: %{href: update_query_params(url, params)}
    }
  end

  defp build_links(url, %{page_number: 1} = params, _) do
    %{
      self: %{href: update_query_params(url, params)},
      next: %{href: update_query_params(url, %{params | page_number: params.page_number + 1})}
    }
  end

  defp build_links(url, %{page_number: page_number} = params, page_count)
       when page_number == page_count do
    %{
      prev: %{href: update_query_params(url, %{params | page_number: params.page_number - 1})},
      self: %{href: update_query_params(url, params)}
    }
  end

  defp build_links(url, params, _) do
    %{
      prev: %{href: update_query_params(url, %{params | page_number: params.page_number - 1})},
      self: %{href: update_query_params(url, params)},
      next: %{href: update_query_params(url, %{params | page_number: params.page_number + 1})}
    }
  end

  def render("index.json", %{players: players, url: url, params: params, page_count: page_count}) do
    %{
      data: render_many(players, PlayerView, "player.json"),
      _links: build_links(url, params, page_count)
    }
  end

  def render("player.json", %{player: player}) do
    player
  end

  def render("index.csv", %{headers: attributes, players: players}) do
    headers = [attributes |> Enum.join(",")]

    headers
    |> Enum.concat(render_many(players, PlayerView, "player.csv"))
    |> Enum.join("\n")
  end

  def render("player.csv", %{player: player}) do
    player
    |> Enum.join(",")
  end
end
