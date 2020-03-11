defmodule Nfl.DataSource do
  use GenServer, restart: :transient

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl GenServer
  def init(_) do
    send(self(), :real_init)
    {:ok, nil}
  end

  @impl GenServer
  def handle_info(:real_init, state) do
    Application.app_dir(:nfl, "priv")
    |> Path.join("rushing.json")
    |> File.read!()
    |> Jason.decode!()
    |> Nfl.Storage.put()

    {:stop, :normal, state}
  end
end
