defmodule NanoPlanner.Schedule.PlanItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias NanoPlanner.Accounts.User

  schema "plan_items" do
    belongs_to :owner, User
    field :name, :string
    field :description, :string, default: ""
    field :all_day, :boolean, default: false
    field :starts_at, :utc_datetime
    field :ends_at, :utc_datetime
    field :starts_on, :date
    field :ends_on, :date
    field :s_date, :date, virtual: true
    field :s_hour, :integer, virtual: true
    field :s_minute, :integer, virtual: true
    field :e_date, :date, virtual: true
    field :e_hour, :integer, virtual: true
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
    |> validate_common_fields()
    |> validate_required(@date_time_fields)
    |> validate_datetime_order()
  end

  def changeset(plan_item, %{"all_day" => "true"} = attrs) do
    plan_item
    |> cast(attrs, @common_fields ++ @date_fields)
    |> change_time_boundaries()
    |> validate_common_fields()
    |> validate_required(@date_fields)
    |> validate_date_order()
  end

  def changeset(plan_item, attrs) do
    plan_item
    |> cast(attrs, @common_fields)
    |> validate_common_fields()
  end

  defp change_starts_at(changeset) do
    d = get_field(changeset, :s_date)
    h = get_field(changeset, :s_hour)
    m = get_field(changeset, :s_minute)

    if dt = get_local_datetime(d, h, m) do
      utc_dt = DateTime.shift_zone!(dt, "Etc/UTC")
      put_change(changeset, :starts_at, utc_dt)
    else
      changeset
    end
  end

  defp change_ends_at(changeset) do
    d = get_field(changeset, :e_date)
    h = get_field(changeset, :e_hour)
    m = get_field(changeset, :e_minute)

    if dt = get_local_datetime(d, h, m) do
      utc_dt = DateTime.shift_zone!(dt, "Etc/UTC")
      put_change(changeset, :ends_at, utc_dt)
    else
      changeset
    end
  end

  defp get_local_datetime(%Date{} = date, hour, minute)
       when hour in 0..23 and minute in 0..59 do
    DateTime.new!(date, Time.new!(hour, minute, 0), time_zone())
  end

  defp get_local_datetime(_date, _hour, _minute), do: nil

  defp change_time_boundaries(changeset) do
    s = convert_to_datetime(get_field(changeset, :starts_on))
    e = convert_to_datetime(get_field(changeset, :starts_on), 1)

    changeset
    |> put_change(:starts_at, s)
    |> put_change(:ends_at, e)
  end

  defp convert_to_datetime(date, delta \\ 0)

  defp convert_to_datetime(%Date{} = date, delta) do
    date
    |> DateTime.new!(Time.new!(0, 0, 0), time_zone())
    |> DateTime.shift_zone!("Etc/UTC")
    |> Timex.shift(days: delta)
  end

  defp convert_to_datetime(_date, _delta), do: nil

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end

  defp validate_common_fields(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, max: 80)
    |> validate_length(:description, max: 400)
  end

  @message "must not be earlier than start date"
  defp validate_date_order(changeset) do
    s = get_field(changeset, :starts_on)
    e = get_field(changeset, :ends_on)

    if s && e do
      if Date.compare(s, e) == :gt do
        add_error(changeset, :ends_on, @message)
      else
        changeset
      end
    else
      changeset
    end
  end

  @message "must not be earlier than start time"
  defp validate_datetime_order(changeset) do
    s = get_field(changeset, :starts_at)
    e = get_field(changeset, :ends_at)

    if s && e do
      if DateTime.compare(s, e) == :gt do
        add_error(changeset, :ends_at, @message)
      else
        changeset
      end
    else
      changeset
    end
  end
end
