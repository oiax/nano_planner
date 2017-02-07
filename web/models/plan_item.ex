defmodule NanoPlanner.PlanItem do
  use NanoPlanner.Web, :model
  alias Timex.Format.DateTime.Formatters.Strftime

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, Timex.Ecto.DateTime
    field :ends_at, Timex.Ecto.DateTime
    field :starts_at_date_part, Timex.Ecto.Date, virtual: true
    field :starts_at_time_part, Timex.Ecto.Time, virtual: true
    field :ends_at_date_part, Timex.Ecto.Date, virtual: true
    field :ends_at_time_part, Timex.Ecto.Time, virtual: true

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
    if item.starts_at do
      if item.starts_at_date_part == nil do
        item = Map.put(item, :starts_at_date_part,
          Timex.to_date(item.starts_at))
      end
      if item.starts_at_time_part == nil do
        item = Map.put(item, :starts_at_time_part,
          Strftime.format!(item.starts_at, "%H:%M"))
      end
    end
    if item.ends_at do
      if item.ends_at_date_part == nil do
        item = Map.put(item, :ends_at_date_part,
          Timex.to_date(item.ends_at))
      end
      if item.ends_at_time_part == nil do
        item = Map.put(item, :ends_at_time_part,
          Strftime.format!(item.ends_at, "%H:%M"))
      end
    end
    item
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
