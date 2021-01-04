# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :geolocation_service,
  ecto_repos: [GeolocationService.Repo],
  file_path: System.get_env("file_path") || "/home/nkmishra-nc/findhotel/geolocation_service/priv/data/data_dump.csv"

# Configures the endpoint
config :geolocation_service, GeolocationServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GGA0dw4cA7CLVbBoIvAqo1HxVe1BVABIWqSexVV9R9b9c18aLCgXj6UXJrWaN3cU",
  render_errors: [view: GeolocationServiceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GeolocationService.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
