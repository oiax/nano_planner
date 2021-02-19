# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nano_planner,
  ecto_repos: [NanoPlanner.Repo]

# Configures the endpoint
config :nano_planner, NanoPlannerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "kps8yDrZtl8+M3P2USEuThL59JBPPdMESwoayN1f4Q9a4YTyhr0fdO6cMcoF06Ef",
  render_errors: [
    view: NanoPlannerWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: NanoPlanner.PubSub,
  live_view: [signing_salt: "7eTMtacR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the default time zone
config :nano_planner,
  default_time_zone: "Asia/Tokyo"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
