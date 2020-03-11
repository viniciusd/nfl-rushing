defmodule Nfl.Players do
  def list() do
    Nfl.Storage.get()
  end

  def filter(data, name) do
    Stream.filter(data, &String.contains?(Map.get(&1, "Player"), name))
  end

  def paginate(data, page_number, page_size) do
    start = page_number * page_size - 1

    data
    |> Stream.drop(start)
    |> Stream.take(page_size)
  end

  def collect(data) do
    Enum.to_list(data)
  end
end
