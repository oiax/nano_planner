defmodule NanoPlanner.PlanItem do
  use NanoPlanner.Web, :model

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, Timex.Ecto.DateTime
    field :ends_at, Timex.Ecto.DateTime
    field :starts_at_date_part, Timex.Ecto.Date, virtual: true
    field :starts_at_hour_part, :integer, virtual: true
    field :starts_at_minute_part, :integer, virtual: true
    field :ends_at_date_part, Timex.Ecto.Date, virtual: true
    field :ends_at_time_part, Timex.Ecto.Time, virtual: true
    field :ends_at_hour_part, :integer, virtual: true
    field :ends_at_minute_part, :integer, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> populate_date_and_time_parts()
    |> cast(params, [])
    |> validate_required([])
  end

  defp populate_date_and_time_parts(%__MODULE__{} = item) do
    item
    |> populate_starts_at_date_part()
    |> populate_ends_at_date_part()
    |> populate_starts_at_time_part()
    |> populate_ends_at_time_part()
  end

  defp populate_starts_at_date_part(%__MODULE__{} = item) do
    if item.starts_at && item.starts_at_date_part == nil do
      Map.put(item, :starts_at_date_part, Timex.to_date(item.starts_at))
    else
      item
    end
  end

  defp populate_ends_at_date_part(%__MODULE__{} = item) do
    if item.ends_at && item.ends_at_date_part == nil do
      Map.put(item, :ends_at_date_part, Timex.to_date(item.ends_at))
    else
      item
    end
  end

  defp populate_starts_at_time_part(%__MODULE__{} = item) do
    if item.starts_at && item.starts_at_hour_part == nil do
      Map.merge(item, %{
        starts_at_hour_part: item.starts_at.hour,
        starts_at_minute_part: item.starts_at.minute
      })
    else
      item
    end
  end

  defp populate_ends_at_time_part(%__MODULE__{} = item) do
    if item.ends_at && item.ends_at_hour_part == nil do
      Map.merge(item, %{
        ends_at_hour_part: item.ends_at.hour,
        ends_at_minute_part: item.ends_at.minute
      })
    else
      item
    end
  end

  def convert_datetime(items) when is_list(items) do
    Enum.map items, &(convert_datetime &1)
  end

  def convert_datetime(%__MODULE__{} = item) do
    alias Timex.Timezone

    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    Map.merge(item, %{
      starts_at: Timezone.convert(item.starts_at, time_zone),
      ends_at: Timezone.convert(item.ends_at, time_zone)
    })
  end
end
