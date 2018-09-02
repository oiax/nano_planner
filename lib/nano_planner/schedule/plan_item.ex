defmodule NanoPlanner.Schedule.PlanItem do
  use Ecto.Schema
  use Timex.Ecto.Timestamps
  import Ecto.Changeset
  alias NanoPlanner.Schedule.PlanItem

  schema "plan_items" do
    field(:name, :string)
    field(:description, :string, default: "")
    field(:starts_at, Timex.Ecto.DateTime)
    field(:ends_at, Timex.Ecto.DateTime)
    field(:s_date, Timex.Ecto.Date, virtual: true)
    field(:s_hour, :integer, virtual: true)
    field(:s_minute, :integer, virtual: true)
    field(:e_date, Timex.Ecto.Date, virtual: true)
    field(:e_hour, :integer, virtual: true)
    field(:e_minute, :integer, virtual: true)

    timestamps()
  end

  @allowed_fields [
    :name,
    :description,
    :s_date,
    :s_hour,
    :s_minute,
    :e_date,
    :e_hour,
    :e_minute
  ]
  def changeset(%PlanItem{} = plan_item, attrs) do
    plan_item
    |> cast(attrs, @allowed_fields)
    |> change_starts_at()
    |> change_ends_at()
  end

  defp change_starts_at(changeset) do
    d = get_field(changeset, :s_date)
    h = get_field(changeset, :s_hour)
    m = get_field(changeset, :s_minute)
    dt = get_local_datetime(d, h, m)
    put_change(changeset, :starts_at, dt)
  end

  defp change_ends_at(changeset) do
    d = get_field(changeset, :e_date)
    h = get_field(changeset, :e_hour)
    m = get_field(changeset, :e_minute)
    dt = get_local_datetime(d, h, m)
    put_change(changeset, :ends_at, dt)
  end

  defp get_local_datetime(date, hour, minute) do
    date
    |> Timex.to_datetime(time_zone())
    |> Timex.shift(hours: hour, minutes: minute)
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end
end
