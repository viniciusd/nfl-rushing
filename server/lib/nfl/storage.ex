defmodule Nfl.Storage do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def put(data) do
    GenServer.cast(__MODULE__, {:put, data})
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  @impl GenServer
  def init(_) do
    {:ok, nil}
  end

  @impl GenServer
  def handle_cast({:put, data}, _store) do
    {:noreply, data}
  end

  @impl GenServer
  def handle_call(:get, _, store) do
    {:reply, store, store}
  end
end
