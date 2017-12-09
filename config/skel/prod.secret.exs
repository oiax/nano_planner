use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :nano_planner, NanoPlannerWeb.Endpoint,
  secret_key_base: "7DwC0N23ePv2EuTWDEOqZRsk/C0YM3rKcV3zdumLPZR0dgG5IaqAHCAsQvUDzOS0"

# Configure your database
config :nano_planner, NanoPlanner.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "phoenix",
  password: "phoenix",
  database: "nano_planner_prod",
  pool_size: 15
