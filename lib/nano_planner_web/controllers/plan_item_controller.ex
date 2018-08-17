defmodule NanoPlannerWeb.PlanItemController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Schedule

  def index(conn, _params) do
    plan_items = Schedule.list_plan_items()
    render(conn, "index.html", plan_items: plan_items)
  end

  def of_today(conn, _params) do
    plan_items = Schedule.list_plan_items_of_today()
    continued_plan_items = Schedule.list_continued_plan_items()

    render(
      conn,
      "of_today.html",
      plan_items: plan_items,
      continued_plan_items: continued_plan_items
    )
  end

  def new(conn, _params) do
    plan_item = Schedule.build_plan_item()
    changeset = Schedule.change_plan_item(plan_item)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plan_item" => plan_item_params}) do
    case Schedule.create_plan_item(plan_item_params) do
      {:ok, _plan_item} ->
        conn
        |> put_flash(:info, "予定を追加しました。")
        |> redirect(to: Routes.plan_item_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "入力に誤りがあります。")
        |> render("new.html", changeset: changeset)
    end
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

    case Schedule.update_plan_item(plan_item, plan_item_params) do
      {:ok, _plan_item} ->
        conn
        |> put_flash(:info, "予定を変更しました。")
        |> redirect(to: Routes.plan_item_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "入力に誤りがあります。")
        |> render("edit.html", plan_item: plan_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plan_item = Schedule.get_plan_item!(id)
    Schedule.delete_plan_item(plan_item)

    conn
    |> put_flash(:info, "予定を削除しました。")
    |> redirect(to: Routes.plan_item_path(conn, :index))
  end
end
