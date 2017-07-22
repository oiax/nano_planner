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
    now = Timex.now("Asia/Tokyo")
    time0 = now |> Timex.beginning_of_day |> Timex.shift(hours: now.hour + 1)
    time1 = time0 |> Timex.shift(hours: 1)
    %PlanItem{ starts_at: time0, ends_at: time1 }
  end

  def change_plan_item(%PlanItem{} = item) do
    PlanItem.changeset(item, %{})
  end

  def create_plan_item(attrs \\ %{}) do
    %PlanItem{}
    |> PlanItem.changeset(attrs)
    |> Repo.insert!()
  end

  defp convert_datetime(items) when is_list(items) do
    Enum.map items, &(convert_datetime &1)
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
