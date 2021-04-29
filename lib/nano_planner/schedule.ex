defmodule NanoPlanner.Schedule do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem

  def list_plan_items do
    PlanItem
    |> order_by(asc: :starts_at)
    |> Repo.all()
    |> convert_datetime()
  end

  def get_plan_item!(id) do
    PlanItem
    |> Repo.get!(id)
    |> convert_datetime()
  end

  def build_plan_item do
    time0 = beginning_of_hour()

    %PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2)
    }
  end

  defp beginning_of_hour do
    Timex.set(current_time(), [minute: 0, second: 0])
  end

  defp current_time do
    time_zone()
    |> DateTime.now!()
    |> DateTime.truncate(:second)
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
    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    Map.merge(item, %{
      starts_at: DateTime.shift_zone!(item.starts_at, time_zone),
      ends_at: DateTime.shift_zone!(item.ends_at, time_zone)
    })
  end
end
