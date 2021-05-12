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
    "DLNGUAsePQl7ZZnt22tC8Q109ve77ynKGEJlfMfSm3XG/tjsgBKzGDlbjZKMGfLD",
  render_errors: [
    view: NanoPlannerWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: NanoPlanner.PubSub,
  live_view: [signing_salt: "qP5nsmEy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the default time zone database
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase
config :nano_planner, NanoPlanner.Repo,
  migration_timestamps: [type: :timestamptz]

# Configures the default time zone
config :nano_planner, default_time_zone: "Asia/Tokyo"

# Configures the default locale
config :nano_planner, NanoPlannerWeb.Gettext, default_locale: "ja"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
