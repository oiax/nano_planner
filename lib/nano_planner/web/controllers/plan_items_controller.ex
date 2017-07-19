defmodule NanoPlanner.Web.PlanItemsController do
  use NanoPlanner.Web, :controller
  import Ecto.Query
  alias NanoPlanner.Repo
  alias NanoPlanner.Calendar
  alias NanoPlanner.Calendar.PlanItem

  def index(conn, _params) do
    plan_items =
      PlanItem
      |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
      |> Repo.all
      |> Calendar.convert_datetime
    render conn, "index.html", plan_items: plan_items
  end

  def show(conn, params) do
    plan_item =
      PlanItem
      |> Repo.get!(params["id"])
      |> Calendar.convert_datetime
    render conn, "show.html", plan_item: plan_item
  end
end
