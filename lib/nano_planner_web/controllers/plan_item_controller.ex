defmodule NanoPlannerWeb.PlanItemController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Schedule
  require Logger

  plug :fetch_plan_item when action in [:show]

  def index(conn, _params) do
    plan_items = Schedule.list_plan_items(conn.assigns[:current_user])
    render(conn, "index.html", plan_items: plan_items)
  end

  def of_today(conn, _params) do
    owner = conn.assigns[:current_user]
    plan_items = Schedule.list_plan_items_of_today(owner)
    continued_plan_items = Schedule.list_continued_plan_items(owner)

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

  def show(conn, _params) do
    render(conn, "show.html")
  end

  def edit(conn, %{"id" => id}) do
    plan_item = Schedule.get_plan_item!(id, conn.assigns[:current_user])
    changeset = Schedule.change_plan_item(plan_item)
    render(conn, "edit.html", plan_item: plan_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plan_item" => plan_item_params}) do
    plan_item = Schedule.get_plan_item!(id, conn.assigns[:current_user])

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
    plan_item = Schedule.get_plan_item!(id, conn.assigns[:current_user])
    Schedule.delete_plan_item(plan_item)

    conn
    |> put_flash(:info, "予定を削除しました。")
    |> redirect(to: Routes.plan_item_path(conn, :index))
  end

  defp fetch_plan_item(conn, _opts) do
    id = conn.params["id"]
    current_user = conn.assigns[:current_user]

    case Schedule.get_plan_item(id, current_user) do
      {:ok, plan_item} ->
        assign(conn, :plan_item, plan_item)

      {:error, :not_found} ->
        conn
        |> put_view(NanoPlannerWeb.CustomErrorView)
        |> render("not_found.html")
        |> halt()
    end
  end
end
