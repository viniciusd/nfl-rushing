defmodule Nfl.AccountsTest do
  use ExUnit.Case

  alias Nfl.Accounts

  alias Nfl.Accounts.User

  @valid_attrs %{age: 42, name: "some name"}
  @update_attrs %{age: 43, name: "some updated name"}
  @invalid_attrs %{age: nil, name: nil}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end

  test "list_users/0 returns all users" do
    user = user_fixture()
    assert Accounts.list_users() == [user]
  end

  test "get_user!/1 returns the user with given id" do
    user = user_fixture()
    assert Accounts.get_user!(user.id) == user
  end
end
