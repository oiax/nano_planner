import Config

get_integer_env = fn var_name, default ->
  case Integer.parse(System.get_env(var_name, "0")) do
    {n, ""} -> n
    _ -> default
  end
end

config :nano_planner, NanoPlanner.Repo,
  hostname: System.get_env("DB_HOST") || "db",
  port: get_integer_env.("DB_PORT", 3306),
  username: System.get_env("DB_USER") || "root",
  password: System.get_env("DB_PASSWORD") || "root",
  database: System.get_env("DB_NAME") || "nano_planner_prod",
  pool_size: get_integer_env.("POOL_SIZE", 10),
  queue_target: get_integer_env.("QUEUE_TARGET", 50),
  queue_interval: get_integer_env.("QUEUE_INTERVAL", 1000)

domain = System.get_env("WEB_HOST") || "example.com"
secret_key_base = System.get_env("SECRET_KEY_BASE")

config :nano_planner, NanoPlannerWeb.Endpoint,
  http: [port: 5000],
  url: [host: domain, port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: secret_key_base,
  server: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
