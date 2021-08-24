defmodule Ecto.SchemaTest do
  use NanoPlanner.DataCase
  import NanoPlanner.AccountsFixtures
  import NanoPlanner.ScheduleFixtures
  alias NanoPlanner.Accounts.User
  alias NanoPlanner.Schedule.PlanItem

  setup do
    {:ok, user: user_fixture()}
  end

  describe "belongs_to/3" do
    test "初期化1" do
      item = %PlanItem{}

      assert %Ecto.Association.NotLoaded{} = item.owner
      assert item.owner_id == nil
    end

    test "初期化2", %{user: user} do
      item = %PlanItem{owner: user}

      assert %User{} = item.owner
      assert item.owner_id == nil
    end

    test "データベースへの挿入", %{user: user} do
      time0 =
        "Asia/Tokyo"
        |> DateTime.now!()
        |> DateTime.truncate(:second)
        |> Timex.beginning_of_day()
        |> DateTime.shift_zone!("Etc/UTC")

      item =
        Repo.insert!(%PlanItem{
          name: "Test",
          description: "",
          starts_at: time0,
          ends_at: Timex.shift(time0, hours: 1),
          owner: user
        })

      assert %User{} = item.owner
      assert item.owner_id == user.id
    end

    test "データベースから取得", %{user: user} do
      item = plan_item_fixture(owner: user)
      fetched = Repo.get!(PlanItem, item.id)

      assert %Ecto.Association.NotLoaded{} = fetched.owner
      assert fetched.owner_id == user.id
    end
  end
end
