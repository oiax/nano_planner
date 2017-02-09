defmodule NanoPlanner.PlanItem do
  use NanoPlanner.Web, :model

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, Timex.Ecto.DateTime
    field :ends_at, Timex.Ecto.DateTime
    field :s_date, Timex.Ecto.Date, virtual: true
    field :s_hour, :integer, virtual: true
    field :s_minute, :integer, virtual: true
    field :e_date, Timex.Ecto.Date, virtual: true
    field :e_hour, :integer, virtual: true
    field :e_minute, :integer, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @allowed_fields [
    :name, :description,
    :s_date, :s_hour, :s_minute,
    :e_date, :e_hour, :e_minute
  ]
  def changeset(struct, params \\ %{}) do
    struct
    |> populate_virtual_fields()
    |> cast(params, @allowed_fields)
    |> populate_changes()
    |> validate_required([])
  end

  defp populate_virtual_fields(%__MODULE__{} = item) do
    item
    |> populate_s_fields()
    |> populate_e_fields()
  end

  defp populate_s_fields(%__MODULE__{} = item) do
    if item.starts_at do
      Map.merge(item, %{
        s_date: Timex.to_date(item.starts_at),
        s_hour: item.starts_at.hour,
        s_minute: item.starts_at.minute
      })
    else
      item
    end
  end

  defp populate_e_fields(%__MODULE__{} = item) do
    if item.ends_at do
      Map.merge(item, %{
        e_date: Timex.to_date(item.ends_at),
        e_hour: item.ends_at.hour,
        e_minute: item.ends_at.minute
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

    Map.merge(item, %{
      starts_at: Timezone.convert(item.starts_at, time_zone()),
      ends_at: Timezone.convert(item.ends_at, time_zone())
    })
  end

  defp populate_changes(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
      |> change_starts_at()
      |> change_ends_at()
  end
  defp populate_changes(changeset), do: changeset

  defp change_starts_at(changeset) do
    item = changeset.data
    d = get_field(changeset, :s_date)
    h = get_field(changeset, :s_hour)
    m = get_field(changeset, :s_minute)
    dt = to_local_datetime(d, h, m)

    changeset |> put_change(:starts_at, dt)
  end

  defp change_ends_at(changeset) do
    item = changeset.data
    d = get_field(changeset, :e_date)
    h = get_field(changeset, :e_hour)
    m = get_field(changeset, :e_minute)
    dt = to_local_datetime(d, h, m)

    changeset |> put_change(:ends_at, dt)
  end

  defp to_local_datetime(date, hour, minute) do
    date
    |> Timex.to_datetime(time_zone())
    |> Timex.shift(hours: hour, minutes: minute)
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end
end
