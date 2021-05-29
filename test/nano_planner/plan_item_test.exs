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

      # Changeset 構造体の changes フィールドを直接書き換える。
      cs = Ecto.Changeset.put_change(cs, :all_day, false)
      assert Ecto.Changeset.get_field(cs, :all_day) == false

      # PlanItem 構造体の all_day フィールドのデフォルト値は false のため、changes フィールドから除外される。
      refute Map.has_key?(cs.changes, :all_day)

      # しかし、input_value/2 は "true" を返す。
      # なぜなら、Changeset 構造体の params フィールドにフォームから入力された値が残っているから。
      #
      # Phoenix.HTML.Form.input_value/2 の公式ドキュメントによれば、次の順で値を取りに行く。
      #   1. changes
      #   2. params
      #   3. data
      f = Phoenix.HTML.Form.form_for(cs, "#")

      assert cs.params["all_day"] == "true"
      assert Phoenix.HTML.Form.input_value(f, :all_day) == "true"

      # 正しくは、cast/3 を用いる。こうすれば params フィールドと changes フィールドが適切に更新される。
      cs = Ecto.Changeset.cast(cs, %{"all_day" => "false"}, [:all_day])

      f = Phoenix.HTML.Form.form_for(cs, "#")

      assert cs.params["all_day"] == "false"
      assert Phoenix.HTML.Form.input_value(f, :all_day) == "false"
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
