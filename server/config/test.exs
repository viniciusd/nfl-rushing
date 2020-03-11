use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nfl, NflWeb.Endpoint,
  http: [port: 4002],
  server: false

config :nfl, :rushing_file, "rushing_test.json"

# Print only warnings and errors during test
config :logger, level: :warn
