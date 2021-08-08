defmodule NanoPlanner.Schedule do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Schedule.PlanItem

  def list_plan_items(owner) do
    fetch_plan_items(PlanItem, owner)
  end

  def list_plan_items_of_today(owner) do
    t0 = Timex.beginning_of_day(current_time())
    t1 = Timex.shift(t0, hours: 24)

    query =
      from i in PlanItem,
        where:
          (i.starts_at >= ^t0 and i.starts_at < ^t1) or
            (i.ends_at > ^t0 and i.ends_at <= ^t1)

    fetch_plan_items(query, owner)
  end

  def list_continued_plan_items(owner) do
    t0 = current_time() |> Timex.beginning_of_day()
    t1 = t0 |> Timex.shift(hours: 24)

    query =
      from i in PlanItem,
        where: i.starts_at < ^t0 and i.ends_at > ^t1

    fetch_plan_items(query, owner)
  end

  defp fetch_plan_items(query, owner) do
    query =
      from i in query,
        where: i.owner_id == ^owner.id,
        order_by: [asc: :starts_at, asc: :all_day, asc: :ends_at, asc: :id]

    query
    |> Repo.all()
    |> convert_datetime()
  end

  def get_plan_item(id, owner) do
    if item = Repo.get(PlanItem, id) do
      if item.owner_id == owner.id do
        {:ok, convert_datetime(item)}
      else
        {:error, :forbidden}
      end
    else
      {:error, :not_found}
    end
  end

  def build_plan_item do
    time0 = beginning_of_hour()
    today = DateTime.to_date(current_time())

    %PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2),
      starts_on: today,
      ends_on: today
    }
  end

  defp beginning_of_hour do
    Timex.set(current_time(), minute: 0, second: 0)
  end

  defp current_time do
    time_zone()
    |> DateTime.now!()
    |> DateTime.truncate(:second)
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end

  def create_plan_item(attrs, owner) do
    %PlanItem{owner_id: owner.id}
    |> PlanItem.changeset(attrs)
    |> Repo.insert()
  end

  def update_plan_item(%PlanItem{} = plan_item, attrs) do
    plan_item
    |> PlanItem.changeset(attrs)
    |> Repo.update()
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
      s_date: DateTime.to_date(item.starts_at),
      s_hour: item.starts_at.hour,
      s_minute: item.starts_at.minute,
      e_date: DateTime.to_date(item.ends_at),
      e_hour: item.ends_at.hour,
      e_minute: item.ends_at.minute
    })
  end

  defp populate_dates(%PlanItem{all_day: false} = item) do
    ends_on =
      case item.ends_at do
        %DateTime{hour: 0, minute: 0} ->
          item.ends_at
          |> DateTime.to_date()
          |> Timex.shift(days: -1)

        _ ->
          DateTime.to_date(item.ends_at)
      end

    Map.merge(item, %{
      starts_on: DateTime.to_date(item.starts_at),
      ends_on: ends_on
    })
  end

  defp populate_dates(%PlanItem{all_day: true} = item), do: item

  defp convert_datetime(items) when is_list(items) do
    Enum.map(items, &convert_datetime(&1))
  end

  defp convert_datetime(%PlanItem{} = item) do
    Map.merge(item, %{
      starts_at: DateTime.shift_zone!(item.starts_at, time_zone()),
      ends_at: DateTime.shift_zone!(item.ends_at, time_zone())
    })
  end

  def set_time_boundaries(%PlanItem{all_day: true} = item) do
    tz = time_zone()

    s =
      item.starts_on
      |> DateTime.new!(Time.new!(0, 0, 0), tz)
      |> DateTime.shift_zone!("Etc/UTC")

    e =
      item.ends_on
      |> DateTime.new!(Time.new!(0, 0, 0), tz)
      |> DateTime.shift_zone!("Etc/UTC")
      |> Timex.shift(days: 1)

    Map.merge(item, %{starts_at: s, ends_at: e})
  end

  def set_time_boundaries(%PlanItem{all_day: false} = item), do: item
end
