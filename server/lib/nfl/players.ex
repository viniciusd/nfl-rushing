defmodule Nfl.Players do
  def list() do
    Nfl.Storage.get()
  end

  def filter(data, name, field \\ "Player") do
    query = name |> String.downcase()
    Stream.filter(data, fn str ->
      str
      |> Map.get(field)
      |> String.downcase()
      |> String.contains?(query)
    end
    )
  end

  def sort(data, nil, _), do: data

  def sort(data, key, "asc") do
    data
    |> Enum.sort_by(&Map.get(&1, key), {:asc, __MODULE__})
  end

  def sort(data, key, "desc") do
    data
    |> Enum.sort_by(&Map.get(&1, key), {:desc, __MODULE__})
  end

  def sort(data, _, _), do: data

  def paginate(data, page_number, page_size) when page_number > 0 and page_size > 0 do
    start = (page_number-1) * page_size

    data
    |> Stream.drop(start)
    |> Stream.take(page_size)
  end

  def paginate(data, _, _) do
    data
  end

  def collect(data) do
    Enum.to_list(data)
  end

  def compare(val1, val2) when is_number(val1) and is_number(val2) and val1 < val2 do
    :lt
  end

  def compare(val1, val2) when is_number(val1) and is_number(val2) and val1 == val2 do
    :eq
  end

  def compare(val1, val2) when is_number(val1) and is_number(val2) and val1 > val2 do
    :gt
  end

  def compare(val1, val2) do
    case {parse_int(val1), parse_int(val2)} do
      {x, y} when x < y -> :lt
      {x, y} when x == y -> :eq
      {x, y} when x > y -> :gt
    end
  end

  defp parse_int(value) when is_number(value), do: value

  defp parse_int(value) do
    case Integer.parse(value) do
      {int, _} -> int
      :error -> value
    end
  end
end
