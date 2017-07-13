defmodule NanoPlanner.Plan do
  alias NanoPlanner.Plan.Item

  import Ecto.{Query, Changeset}, warn: false

  @doc """
  Builds a changeset based on the `struct` and `attrs`.
  """
  def item_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [])
    |> validate_required([])
  end

  def convert_datetime(items) when is_list(items) do
    Enum.map items, &(convert_datetime &1)
  end

  def convert_datetime(%Item{} = item) do
    alias Timex.Timezone

    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    Map.merge(item, %{
      starts_at: Timezone.convert(item.starts_at, time_zone),
      ends_at: Timezone.convert(item.ends_at, time_zone)
    })
  end
end
