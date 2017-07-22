defmodule NanoPlanner.Web.PlanItemController do
  use NanoPlanner.Web, :controller
  alias NanoPlanner.Calendar

  def index(conn, _params) do
    plan_items = Calendar.list_plan_items
    render conn, "index.html", plan_items: plan_items
  end

  def new(conn, _params) do
    plan_item = Calendar.build_plan_item
    changeset = Calendar.change_plan_item(plan_item)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plan_item" => plan_item_params}) do
    Calendar.create_plan_item(plan_item_params)
    redirect(conn, to: plan_item_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    plan_item = Calendar.get_plan_item!(id)
    render conn, "show.html", plan_item: plan_item
  end
end
