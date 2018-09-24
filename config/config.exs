# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nano_planner,
  ecto_repos: [NanoPlanner.Repo]

# Configures the endpoint
config :nano_planner, NanoPlannerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "4lPeMuSkPKsaRx2zl5aFgvS2cJqSrqc7fd6FBro3cgzkgGXJMEDwYa2oVeCcs3st",
  render_errors: [view: NanoPlannerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NanoPlanner.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason

# Configures the default time zone
config :nano_planner, default_time_zone: "Asia/Tokyo"

# Configures the default locale
config :nano_planner, NanoPlannerWeb.Gettext, default_locale: "ja"

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
