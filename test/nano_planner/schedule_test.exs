defmodule NanoPlanner.ScheduleTest do
  use NanoPlanner.DataCase

  alias NanoPlanner.Schedule

  describe "plan_items" do
    alias NanoPlanner.Schedule.PlanItem

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def plan_item_fixture(attrs \\ %{}) do
      {:ok, plan_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_plan_item()

      plan_item
    end

    test "list_plan_items/0 returns all plan_items" do
      plan_item = plan_item_fixture()
      assert Schedule.list_plan_items() == [plan_item]
    end

    test "get_plan_item!/1 returns the plan_item with given id" do
      plan_item = plan_item_fixture()
      assert Schedule.get_plan_item!(plan_item.id) == plan_item
    end

    test "create_plan_item/1 with valid data creates a plan_item" do
      assert {:ok, %PlanItem{} = plan_item} = Schedule.create_plan_item(@valid_attrs)
    end

    test "create_plan_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_plan_item(@invalid_attrs)
    end

    test "update_plan_item/2 with valid data updates the plan_item" do
      plan_item = plan_item_fixture()
      assert {:ok, %PlanItem{} = plan_item} = Schedule.update_plan_item(plan_item, @update_attrs)
    end

    test "update_plan_item/2 with invalid data returns error changeset" do
      plan_item = plan_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_plan_item(plan_item, @invalid_attrs)
      assert plan_item == Schedule.get_plan_item!(plan_item.id)
    end

    test "delete_plan_item/1 deletes the plan_item" do
      plan_item = plan_item_fixture()
      assert {:ok, %PlanItem{}} = Schedule.delete_plan_item(plan_item)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_plan_item!(plan_item.id) end
    end

    test "change_plan_item/1 returns a plan_item changeset" do
      plan_item = plan_item_fixture()
      assert %Ecto.Changeset{} = Schedule.change_plan_item(plan_item)
    end
  end
end
