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
