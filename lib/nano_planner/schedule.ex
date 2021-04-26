defmodule NanoPlanner.Schedule do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem

  def list_plan_items do
    PlanItem
    |> order_by(asc: :starts_at)
    |> Repo.all()
  end
end
