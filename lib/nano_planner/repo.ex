defmodule NanoPlanner.Repo do
  use Ecto.Repo,
    otp_app: :nano_planner,
    adapter: Ecto.Adapters.Postgres
end
