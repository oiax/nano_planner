defmodule NanoPlanner.Calendar do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Calendar.PlanItem

  def list_plan_items do
    PlanItem
    |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
    |> Repo.all
    |> convert_datetime
  end

  def get_plan_item!(id) do
    PlanItem
    |> Repo.get!(id)
    |> convert_datetime
  end

  def build_plan_item do
    time0 = beginning_of_hour()

    %PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2)
    }
  end

  defp beginning_of_hour do
    %{Timex.now(time_zone()) | minute: 0, second: 0, microsecond: {0, 0}}
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end

  def change_plan_item(%PlanItem{} = item) do
    PlanItem.changeset(item, %{})
  end

  defp convert_datetime(items) when is_list(items) do
    Enum.map(items, &convert_datetime(&1))
  end

  defp convert_datetime(%PlanItem{} = item) do
    alias Timex.Timezone

    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    Map.merge(item, %{
      starts_at: Timezone.convert(item.starts_at, time_zone),
      ends_at: Timezone.convert(item.ends_at, time_zone)
    })
  end
end
