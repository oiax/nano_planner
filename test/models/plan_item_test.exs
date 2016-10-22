defmodule NanoPlanner.PlanItemTest do
  use NanoPlanner.ModelCase

  alias NanoPlanner.PlanItem

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PlanItem.changeset(%PlanItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PlanItem.changeset(%PlanItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
