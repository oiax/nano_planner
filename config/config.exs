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
config :nano_planner, NanoPlanner.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+rpXBXRuoM3w08d/lxZ8JSk2Z11fM93rIf3AKHz30bk+SNVCW4A1/VPNnJOAFoNh",
  render_errors: [view: NanoPlanner.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NanoPlanner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the default time zone
config :nano_planner,
  default_time_zone: "Asia/Tokyo"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
