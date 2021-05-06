defmodule NanoPlanner.Schedule do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem

  def list_plan_items do
    PlanItem
    |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
    |> Repo.all()
    |> convert_datetime()
  end

  defp convert_datetime(items) do
    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    Enum.map(items, fn item ->
      Map.merge(item, %{
        starts_at: DateTime.shift_zone!(item.starts_at, time_zone),
        ends_at: DateTime.shift_zone!(item.ends_at, time_zone)
      })
    end)
  end
end
