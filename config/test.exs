use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :geolocation_service, GeolocationServiceWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :geolocation_service, GeolocationService.Repo,
  username: "postgres",
  password: "postgres",
  database: "geolocation_service_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
