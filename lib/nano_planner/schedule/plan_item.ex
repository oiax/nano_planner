defmodule NanoPlanner.Schedule.PlanItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plan_items" do
    field :name, :string
    field :description, :string, default: ""
    field :all_day, :boolean, default: false
    field :starts_at, :utc_datetime
    field :ends_at, :utc_datetime
    field :s_date, :date, virtual: true
    field :s_hour, :integer, virtual: true
    field :s_minute, :integer, virtual: true
    field :e_date, :date, virtual: true
    field :e_hour, :integer, virtual: true
    field :starts_on, :date
    field :ends_on, :date
    field :e_minute, :integer, virtual: true

    timestamps(type: :utc_datetime_usec)
  end

  @common_fields [
    :name,
    :description,
    :all_day
  ]

  @date_time_fields [
    :s_date,
    :s_hour,
    :s_minute,
    :e_date,
    :e_hour,
    :e_minute
  ]

  @date_fields [
    :starts_on,
    :ends_on
  ]

  @doc false
  def changeset(plan_item, %{"all_day" => "false"} = attrs) do
    plan_item
    |> cast(attrs, @common_fields ++ @date_time_fields)
    |> change_starts_at()
    |> change_ends_at()
    |> validate_required([:name])
  end

  def changeset(plan_item, %{"all_day" => "true"} = attrs) do
    plan_item
    |> cast(attrs, @common_fields ++ @date_fields)
    |> change_time_boundaries()
    |> validate_required([:name])
  end

  def changeset(plan_item, attrs) do
    plan_item
    |> cast(attrs, @common_fields)
    |> validate_required([:name])
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

  defp change_time_boundaries(changeset) do
    tz = time_zone()

    s =
      changeset
      |> get_field(:starts_on)
      |> DateTime.new!(Time.new!(0, 0, 0), tz)

    e =
      changeset
      |> get_field(:ends_on)
      |> DateTime.new!(Time.new!(0, 0, 0), tz)
      |> Timex.shift(days: 1)

    changeset
    |> put_change(:starts_at, s)
    |> put_change(:ends_at, e)
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end
end
