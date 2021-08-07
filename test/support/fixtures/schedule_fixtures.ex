defmodule NanoPlanner.ScheduleFixtures do
  import NanoPlanner.Repo, only: [insert!: 1]
  import NanoPlanner.AccountsFixtures
  alias NanoPlanner.Schedule.PlanItem

  def plan_item_fixture(attrs) do
    owner = attrs[:owner] || user_fixture()

    insert!(%PlanItem{
      name: attrs[:name] || "Test",
      description: attrs[:description] || "Description",
      starts_at: attrs[:starts_at] || get_time(1, 12),
      ends_at: attrs[:ends_at] || get_time(1, 13),
      owner_id: owner.id
    })
  end

  defp get_time(days, hours) do
    "Asia/Tokyo"
    |> DateTime.now!()
    |> DateTime.truncate(:second)
    |> Timex.beginning_of_day()
    |> DateTime.shift_zone!("Etc/UTC")
    |> Timex.shift(days: days, hours: hours)
  end
end
