defmodule NanoPlanner.Schedule.PlanItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plan_items" do
    field :name, :string
    field :description, :string, default: ""
    field :starts_at, :utc_datetime
    field :ends_at, :utc_datetime
    field :s_date, :date, virtual: true
    field :s_hour, :integer, virtual: true
    field :s_minute, :integer, virtual: true
    field :e_date, :date, virtual: true
    field :e_hour, :integer, virtual: true
    field :e_minute, :integer, virtual: true

    timestamps(type: :utc_datetime_usec)
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

  @doc false
  def changeset(plan_item, attrs) do
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
    utc_dt = DateTime.shift_zone!(dt, "Etc/UTC")
    put_change(changeset, :starts_at, utc_dt)
  end

  defp change_ends_at(changeset) do
    d = get_field(changeset, :e_date)
    h = get_field(changeset, :e_hour)
    m = get_field(changeset, :e_minute)
    dt = get_local_datetime(d, h, m)
    utc_dt = DateTime.shift_zone!(dt, "Etc/UTC")
    put_change(changeset, :ends_at, utc_dt)
  end

  defp get_local_datetime(date, hour, minute) do
    DateTime.new!(date, Time.new!(hour, minute, 0), time_zone())
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end
end
