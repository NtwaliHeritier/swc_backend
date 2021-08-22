# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :swc_backend,
  ecto_repos: [SwcBackend.Repo]

# Configures the endpoint
config :swc_backend, SwcBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tNbwi+lNNuwrhOeg93I61OW7RMNFRDzZqaw6uBI/EZmr6b6JRpie+EsHqzOMjIAQ",
  render_errors: [view: SwcBackendWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SwcBackend.PubSub,
  live_view: [signing_salt: "S1Ik7WxM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
