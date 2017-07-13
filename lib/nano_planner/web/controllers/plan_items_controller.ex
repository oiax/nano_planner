defmodule NanoPlanner.Web.PlanItemsController do
  use NanoPlanner.Web, :controller
  import Ecto.{Query, Changeset}, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Plan

  def index(conn, _params) do
    plan_items =
      Plan.Item
      |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
      |> Repo.all
      |> Plan.convert_datetime
    render conn, "index.html", plan_items: plan_items
  end

  def show(conn, params) do
    plan_item =
      Plan.Item
      |> Repo.get!(params["id"])
      |> Plan.convert_datetime
    render conn, "show.html", plan_item: plan_item
  end
end
