defmodule NanoPlanner.Schedule do
  import Ecto.Query
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem

  def list_plan_items do
    PlanItem
    |> fetch_plan_items()
  end

  def list_plan_items_of_today do
    t0 = current_time() |> Timex.beginning_of_day()
    t1 = t0 |> Timex.shift(hours: 24)

    PlanItem
    |> where([i], i.starts_at >= ^t0 and i.starts_at < ^t1)
    |> or_where([i], i.ends_at > ^t0 and i.ends_at <= ^t1)
    |> fetch_plan_items()
  end

  def list_continued_plan_items do
    t0 = current_time() |> Timex.beginning_of_day()
    t1 = t0 |> Timex.shift(hours: 24)

    PlanItem
    |> where([i], i.starts_at < ^t0 and i.ends_at > ^t1)
    |> fetch_plan_items()
  end

  defp fetch_plan_items(query) do
    query
    |> order_by(asc: :starts_at, asc: :all_day, asc: :ends_at, asc: :id)
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
    today = current_time() |> Timex.to_date()

    %PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2),
      starts_on: today,
      ends_on: today
    }
  end

  defp beginning_of_hour do
    Timex.set(current_time(), minute: 0, second: 0, microsecond: {0, 0})
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
    |> populate_dates()
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

  defp populate_dates(%PlanItem{all_day: false} = item) do
    ends_on =
      case item.ends_at do
        %DateTime{hour: 0, minute: 0} ->
          item.ends_at |> Timex.to_date() |> Timex.shift(days: -1)
        _ ->
          item.ends_at |> Timex.to_date()
      end

    Map.merge(item, %{
      starts_on: Timex.to_date(item.starts_at),
      ends_on: ends_on
    })
  end
  defp populate_dates(%PlanItem{all_day: true} = item), do: item

  defp convert_datetime(items) when is_list(items) do
    Enum.map(items, &convert_datetime(&1))
  end

  defp convert_datetime(%PlanItem{} = item) do
    alias Timex.Timezone

    Map.merge(item, %{
      starts_at: Timezone.convert(item.starts_at, time_zone()),
      ends_at: Timezone.convert(item.ends_at, time_zone())
    })
  end

  def set_time_boundaries(%PlanItem{all_day: true} = item) do
    tz = time_zone()

    Map.merge(item, %{
      starts_at: Timex.to_datetime(item.starts_on, tz),
      ends_at: Timex.shift(Timex.to_datetime(item.ends_on, tz), days: 1)
    })
  end

  def set_time_boundaries(%PlanItem{all_day: false} = item) do
    item
  end
end
