defmodule NanoPlannerWeb.PlanItemControllerTest do
  use NanoPlannerWeb.ConnCase, async: true
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem
  import NanoPlanner.ScheduleFixtures

  describe "index/2" do
    setup do
      plan_item_fixture([])
      plan_item_fixture([])
      :ok
    end

    test "予定項目の一覧を表示する", %{conn: conn} do
      conn = get(conn, Routes.plan_item_path(conn, :index))
      plan_items = conn.assigns.plan_items

      assert conn.status == 200
      assert length(plan_items) == 2
    end
  end

  describe "create/2" do
    test "予定項目を追加する", %{conn: conn} do
      params = %{
        "plan_item" => %{
          "name" => "Test",
          "description" => "",
          "all_day" => "false",
          "s_date" => "2021-08-01",
          "s_hour" => "12",
          "s_minute" => "00",
          "e_date" => "2021-08-01",
          "e_hour" => "13",
          "e_minute" => "00"
        }
      }

      conn = post(conn, Routes.plan_item_path(conn, :create), params)
      [item] = Repo.all(PlanItem)

      assert redirected_to(conn) =~ "/"
      assert item.name == "Test"
    end
  end
end
