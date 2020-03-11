# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :nfl, NflWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h7glkImmDA7R2/OHoq9gmim+S7qEA0qWTMlRP35Mhxhz67Xic+zRCEcF7WsB4cuo",
  render_errors: [view: NflWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Nfl.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "Wp17MDRs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :nfl, :rushing_file, "rushing.json"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
