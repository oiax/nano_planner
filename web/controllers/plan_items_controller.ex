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
    time0 = beginning_of_hour()
    changeset = PlanItem.changeset(%PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2)
    })
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plan_item" => plan_item_params}) do
    changeset = PlanItem.changeset(%PlanItem{}, plan_item_params)

    case Repo.insert(changeset) do
      {:ok, _plan_item} ->
        conn
        |> put_flash(:info, "Plan item created successfully.")
        |> redirect(to: plan_items_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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

  def update(conn, %{"id" => id, "plan_item" => plan_item_params}) do
    changeset =
      PlanItem
      |> Repo.get!(id)
      |> PlanItem.convert_datetime
      |> PlanItem.changeset(user_params)

    case Repo.update(changeset) do
      {:ok, _plan_item} ->
        conn
        |> put_flash(:info, "Plan item updated successfully.")
        |> redirect(to: plan_items_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  defp beginning_of_hour do
    time_zone = Application.get_env(:nano_planner, :default_time_zone)
    %{Timex.now(time_zone) | :minute => 0, :second => 0, :microsecond => {0,0}}
  end
end
