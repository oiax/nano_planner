defmodule NanoPlanner.Schedule.PlanItemTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Schedule
  alias NanoPlanner.Schedule.PlanItem

  describe "Phoenix.HTML.Form.input_value/2" do
    test "バリデーション成功の場合" do
      plan_item = Schedule.build_plan_item()

      attrs = %{
        "name" => "Name",
        "all_day" => "true",
        "starts_on" => "2021-08-01",
        "ends_on" => "2021-08-02"
      }

      cs = PlanItem.changeset(plan_item, attrs)

      assert cs.valid?

      starts_at = Ecto.Changeset.get_change(cs, :starts_at)
      assert starts_at == ~U[2021-07-31 15:00:00Z]

      f = Phoenix.HTML.Form.form_for(cs, "#")
      assert Phoenix.HTML.Form.input_value(f, :all_day) == true
    end

    test "バリデーション失敗の場合" do
      plan_item = Schedule.build_plan_item()

      attrs = %{
        "name" => "Name",
        "all_day" => "true",
        "starts_on" => "2021-08-02",
        "ends_on" => "2021-08-01"
      }

      cs = PlanItem.changeset(plan_item, attrs)

      starts_at = Ecto.Changeset.get_change(cs, :starts_at)
      assert starts_at == ~U[2021-08-01 15:00:00Z]

      refute cs.valid?

      f = Phoenix.HTML.Form.form_for(cs, "#")
      assert Phoenix.HTML.Form.input_value(f, :all_day) == true
    end
  end
end
