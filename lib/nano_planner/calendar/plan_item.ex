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

    timestamps()
  end

  def changeset(%PlanItem{} = plan_item, attrs) do
    plan_item
    |> cast(attrs, [:name, :description, :starts_at, :ends_at])
  end
end
