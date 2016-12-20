defmodule NanoPlanner.PlanItem do
  use NanoPlanner.Web, :model

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, Timex.Ecto.DateTime
    field :ends_at, Timex.Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end

  def convert_datetime(items) when is_list(items) do
    Enum.map items, &(convert_datetime(&1))
  end

  def convert_datetime(item) when is_map(item) do
    alias Timex.Timezone

    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    item
      |> Map.put(:starts_at, Timezone.convert(item.starts_at, time_zone))
      |> Map.put(:ends_at, Timezone.convert(item.ends_at, time_zone))
  end
end
