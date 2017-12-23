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
    Timex.set(current_time(), minute: 0, second: 0, microsecond: {0, 6})
  end

  defp current_time do
    Timex.now(time_zone())
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end

  def create_plan_item(attrs) do
    %PlanItem{}
    |> PlanItem.changeset(attrs)
    |> Repo.insert!()
  end

  def update_plan_item(%PlanItem{} = plan_item, attrs) do
    plan_item
    |> PlanItem.changeset(attrs)
    |> Repo.update!()
  end

  def delete_plan_item(%PlanItem{} = plan_item) do
    Repo.delete(plan_item)
  end

  def change_plan_item(%PlanItem{} = item) do
    item
    |> populate_virtual_fields()
    |> PlanItem.changeset(%{})
  end

  defp populate_virtual_fields(item) do
    Map.merge(item, %{
      s_date: Timex.to_date(item.starts_at),
      s_hour: item.starts_at.hour,
      s_minute: item.starts_at.minute,
      e_date: Timex.to_date(item.ends_at),
      e_hour: item.ends_at.hour,
      e_minute: item.ends_at.minute
    })
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
