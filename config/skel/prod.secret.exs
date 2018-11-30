use Mix.Config

config :nano_planner, NanoPlanner.Web.Endpoint,
  secret_key_base: "aTtXMWdvDAmJb9JvCS4fAGQGF3F7z1BJ3J6+xk8KJUSRrXWP2qWgE5q2UfGvSI9W"

config :nano_planner, NanoPlanner.Repo,
  username: "postgres",
  password: "postgres",
  database: "nano_planner_prod",
  pool_size: 15,
  hostname: "127.0.0.1"
