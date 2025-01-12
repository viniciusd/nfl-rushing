defmodule NflWeb.PlayerControllerTest do
  use NflWeb.ConnCase

  alias Nfl.Players

  @players [
    %{
      "Player" => "Joe Banyard",
      "Team" => "JAX",
      "Pos" => "RB",
      "Att" => 2,
      "Att/G" => 2,
      "Yds" => 7,
      "Avg" => 3.5,
      "Yds/G" => 7,
      "TD" => 0,
      "Lng" => "7",
      "1st" => 0,
      "1st%" => 0,
      "20+" => 0,
      "40+" => 0,
      "FUM" => 0
    },
    %{
      "Player" => "Shaun Hill",
      "Team" => "MIN",
      "Pos" => "QB",
      "Att" => 5,
      "Att/G" => 1.7,
      "Yds" => 5,
      "Avg" => 1,
      "Yds/G" => 1.7,
      "TD" => 0,
      "Lng" => "9",
      "1st" => 0,
      "1st%" => 0,
      "20+" => 0,
      "40+" => 0,
      "FUM" => 0
    },
    %{
      "Player" => "Breshad Perriman",
      "Team" => "BAL",
      "Pos" => "WR",
      "Att" => 1,
      "Att/G" => 0.1,
      "Yds" => 2,
      "Avg" => 2,
      "Yds/G" => 0.1,
      "TD" => 0,
      "Lng" => "2",
      "1st" => 0,
      "1st%" => 0,
      "20+" => 0,
      "40+" => 0,
      "FUM" => 0
    },
    %{
      "Player" => "Charlie Whitehurst",
      "Team" => "CLE",
      "Pos" => "QB",
      "Att" => 2,
      "Att/G" => 2,
      "Yds" => 1,
      "Avg" => 0.5,
      "Yds/G" => 1,
      "TD" => 0,
      "Lng" => "2",
      "1st" => 0,
      "1st%" => 0,
      "20+" => 0,
      "40+" => 0,
      "FUM" => 0
    },
    %{
      "Player" => "Lance Dunbar",
      "Team" => "DAL",
      "Pos" => "RB",
      "Att" => 9,
      "Att/G" => 0.7,
      "Yds" => 31,
      "Avg" => 3.4,
      "Yds/G" => 2.4,
      "TD" => 1,
      "Lng" => "10",
      "1st" => 3,
      "1st%" => 33.3,
      "20+" => 0,
      "40+" => 0,
      "FUM" => 0
    },
    %{
      "Player" => "Mark Ingram",
      "Team" => "NO",
      "Pos" => "RB",
      "Att" => 205,
      "Att/G" => 12.8,
      "Yds" => "1,043",
      "Avg" => 5.1,
      "Yds/G" => 65.2,
      "TD" => 6,
      "Lng" => "75T",
      "1st" => 49,
      "1st%" => 23.9,
      "20+" => 4,
      "40+" => 2,
      "FUM" => 2
    }
  ]
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all players", %{conn: conn} do
      conn = get(conn, Routes.player_path(conn, :index))
      assert json_response(conn, 200)["data"] == @players
    end
  end
end
