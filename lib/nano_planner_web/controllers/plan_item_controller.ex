defmodule NanoPlannerWeb.PlanItemController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Schedule

  def index(conn, _params) do
    plan_items = Schedule.list_plan_items()
    render(conn, "index.html", plan_items: plan_items)
  end
end
