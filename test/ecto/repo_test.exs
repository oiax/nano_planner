defmodule Ecto.RepoTest do
  use NanoPlanner.DataCase
  import NanoPlanner.AccountsFixtures
  import NanoPlanner.ScheduleFixtures
  alias NanoPlanner.Accounts.User
  alias NanoPlanner.Schedule.PlanItem

  setup do
    {:ok, user: user_fixture()}
  end

  describe "preload/3" do
    test "予定項目のownerをプリロードする", %{user: user} do
      item = plan_item_fixture(owner: user)
      fetched = Repo.get!(PlanItem, item.id)
      loaded = Repo.preload(fetched, :owner)

      assert %Ecto.Association.NotLoaded{} = fetched.owner
      assert %User{} = loaded.owner
    end
  end

  describe ":preload キー" do
    test "予定項目のownerをプリロードする", %{user: user} do
      item = plan_item_fixture(owner: user)

      query =
        from i in PlanItem,
          where: i.id == ^item.id,
          preload: :owner

      fetched = Repo.one!(query)

      assert %User{} = fetched.owner
    end
  end

  describe "テーブル結合" do
    test "予定項目のownerをプリロードする", %{user: user} do
      item = plan_item_fixture(owner: user)

      query =
        from i in PlanItem,
          where: i.id == ^item.id,
          join: u in assoc(i, :owner),
          on: i.owner_id == u.id,
          select: %{i | owner: u}

      fetched = Repo.one!(query)

      assert %User{} = fetched.owner
    end
  end
end
