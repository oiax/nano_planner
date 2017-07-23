defmodule NanoPlanner.Calendar.PlanItem do
  use Ecto.Schema
  use Timex.Ecto.Timestamps
  import Ecto.Changeset
  alias NanoPlanner.Calendar.PlanItem

  schema "plan_items" do
    field :name, :string
    field :description, :string, default: ""
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

  @allowed_fields [
    :name, :description,
    :s_date, :s_hour, :s_minute,
    :e_date, :e_hour, :e_minute
  ]
  def changeset(%PlanItem{} = plan_item, attrs) do
    plan_item
    |> cast(attrs, @allowed_fields)
  end
end
