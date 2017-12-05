defmodule NanoPlanner.PlanItemsController do
  use NanoPlanner.Web, :controller
  alias NanoPlanner.PlanItem

  def index(conn, _params) do
    plan_items =
      PlanItem
      |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
      |> Repo.all
    render conn, "index.html", plan_items: plan_items
  end
end
