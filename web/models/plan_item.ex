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
    |> populate_date_and_times()
    |> cast(params, @allowed_fields)
    |> validate_required([])
    |> before_save()
  end

  defp populate_date_and_times(%__MODULE__{} = item) do
    item
    |> populate_s_date()
    |> populate_e_date()
    |> populate_s_time()
    |> populate_e_time()
  end

  defp populate_s_date(%__MODULE__{} = item) do
    if item.starts_at && item.s_date == nil do
      Map.put(item, :s_date, Timex.to_date(item.starts_at))
    else
      item
    end
  end

  defp populate_e_date(%__MODULE__{} = item) do
    if item.ends_at && item.e_date == nil do
      Map.put(item, :e_date, Timex.to_date(item.ends_at))
    else
      item
    end
  end

  defp populate_s_time(%__MODULE__{} = item) do
    if item.starts_at && item.s_hour == nil do
      Map.merge(item, %{
        s_hour: item.starts_at.hour,
        s_minute: item.starts_at.minute
      })
    else
      item
    end
  end

  defp populate_e_time(%__MODULE__{} = item) do
    if item.ends_at && item.e_hour == nil do
      Map.merge(item, %{
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

  defp before_save(changeset) do
    if changeset.valid? do
      changeset
        |> populate_starts_at()
        |> populate_ends_at()
    else
      changeset
    end
  end

  defp populate_starts_at(changeset) do
    item = changeset.data
    d = get_field(changeset, :s_date)
    h = get_field(changeset, :s_hour)
    m = get_field(changeset, :s_minute)
    dt = to_local_datetime(d, h, m)

    changeset |> put_change(:starts_at, dt)
  end

  defp populate_ends_at(changeset) do
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
