defmodule NanoPlanner.PlanItemsController do
  use NanoPlanner.Web, :controller
  alias NanoPlanner.PlanItem

  def index(conn, _params) do
    plan_items = Repo.all(PlanItem)
    render conn, "index.html", plan_items: plan_items
  end
end
