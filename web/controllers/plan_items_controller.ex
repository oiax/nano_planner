defmodule NanoPlanner.PlanItemsController do
  use NanoPlanner.Web, :controller
  alias NanoPlanner.PlanItem

  def index(conn, _params) do
    render conn, "index.html", plan_items: Repo.all(PlanItem)
  end
end
