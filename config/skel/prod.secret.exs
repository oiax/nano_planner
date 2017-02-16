use Mix.Config

config :nano_planner, NanoPlanner.Endpoint,
  secret_key_base: "CHANGE_HERE"

config :nano_planner, NanoPlanner.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "phoenix",
  password: "phoenix",
  database: "nano_planner_prod",
  pool_size: 20
