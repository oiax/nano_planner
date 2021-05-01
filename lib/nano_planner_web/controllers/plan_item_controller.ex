defmodule NanoPlannerWeb.PlanItemController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Schedule

  def index(conn, _params) do
    plan_items = Schedule.list_plan_items()
    render(conn, "index.html", plan_items: plan_items)
  end

  def new(conn, _params) do
    plan_item = Schedule.build_plan_item()
    changeset = Schedule.change_plan_item(plan_item)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plan_item" => plan_item_params}) do
    Schedule.create_plan_item(plan_item_params)

    conn
    |> put_flash(:info, "予定を追加しました。")
    |> redirect(to: Routes.plan_item_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    plan_item = Schedule.get_plan_item!(id)
    render(conn, "show.html", plan_item: plan_item)
  end

  def edit(conn, %{"id" => id}) do
    plan_item = Schedule.get_plan_item!(id)
    changeset = Schedule.change_plan_item(plan_item)
    render(conn, "edit.html", plan_item: plan_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plan_item" => plan_item_params}) do
    plan_item = Schedule.get_plan_item!(id)
    Schedule.update_plan_item(plan_item, plan_item_params)

    conn
    |> put_flash(:info, "予定を変更しました。")
    |> redirect(to: Routes.plan_item_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    plan_item = Schedule.get_plan_item!(id)
    Schedule.delete_plan_item(plan_item)

    conn
    |> put_flash(:info, "予定を削除しました。")
    |> redirect(to: Routes.plan_item_path(conn, :index))
  end
end
