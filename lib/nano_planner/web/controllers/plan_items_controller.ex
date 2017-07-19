defmodule NanoPlanner.Web.PlanItemsController do
  use NanoPlanner.Web, :controller
  alias NanoPlanner.Calendar

  def index(conn, _params) do
    plan_items = Calendar.list_plan_items
    render conn, "index.html", plan_items: plan_items
  end

  def show(conn, %{"id" => id}) do
    plan_item = Calendar.get_plan_item!(id)
    render conn, "show.html", plan_item: plan_item
  end
end
