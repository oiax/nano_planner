defmodule NanoPlanner.PlanItemsController do
  use NanoPlanner.Web, :controller
  alias NanoPlanner.PlanItem

  def index(conn, _params) do
    plan_items =
      PlanItem
      |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
      |> Repo.all
      |> PlanItem.convert_datetime
    render conn, "index.html", plan_items: plan_items
  end

  def new(conn, _params) do
    now = Timex.now("Asia/Tokyo")
    time0 = now |> Timex.beginning_of_day |> Timex.shift(hours: now.hour)
    changeset = PlanItem.changeset(%PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2)
    })
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, params) do
    plan_item =
      PlanItem
      |> Repo.get!(params["id"])
      |> PlanItem.convert_datetime
    render conn, "show.html", plan_item: plan_item
  end

  def edit(conn, params) do
    changeset =
      PlanItem
      |> Repo.get!(params["id"])
      |> PlanItem.convert_datetime
      |> PlanItem.changeset
    render(conn, "edit.html", changeset: changeset)
  end
end
