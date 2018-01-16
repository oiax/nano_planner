defmodule NanoPlannerWeb.PlanItemController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Calendar

  def index(conn, _params) do
    plan_items = Calendar.list_plan_items
    render conn, "index.html", plan_items: plan_items
  end

  def new(conn, _params) do
    plan_item = Calendar.build_plan_item
    changeset = Calendar.change_plan_item(plan_item)
    render conn, "new.html", changeset: changeset
  end

  def create(conn, _params) do
    redirect conn, to: plan_item_path(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    plan_item = Calendar.get_plan_item!(id)
    render conn, "show.html", plan_item: plan_item
  end
end
