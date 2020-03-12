defmodule Nfl.PlayersTest do
  use ExUnit.Case

  alias Nfl.Players

  @joe %{
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
  }
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
  @sorted_players [
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

  test "list/0 returns all users" do
    assert Players.list_all() == @players
  end

  test "filter/2 searches for players that contain the given query" do
    result =
      Players.list_all()
      |> Players.filter("Joe")
      |> Players.collect()

    assert result == [@joe]
  end

  test "filter/2 performs a case insensitive search" do
    result =
      Players.list_all()
      |> Players.filter("joe")
      |> Players.collect()

    assert result == [@joe]
  end

  test "sort/3 can sort by a given key" do
    result =
      Players.list_all()
      |> Players.sort("TD", "asc")
      |> Players.collect()

    assert result == @sorted_players
  end

  test "sort/3 can sort by descending order" do
    result =
      Players.list_all()
      |> Players.sort("TD", "desc")
      |> Players.collect()
      |> Enum.take(2)

    reversed =
      @sorted_players
      |> Enum.reverse()
      |> Enum.take(2)

    assert result == reversed
  end

  test "paginate/3 can return the given page" do
    {_, first_page} =
      Players.list_all()
      |> Players.paginate(1, 4)
      |> Players.collect()

    page =
      @players
      |> Enum.take(4)

    assert first_page == page
  end

  test "paginate/3 returns the page count" do
    {page_count, _} =
      Players.list_all()
      |> Players.paginate(1, 4)
      |> Players.collect()

    assert page_count == 2
  end
end
