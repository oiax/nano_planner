defmodule NanoPlanner.Schedule.PlanItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plan_items" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(plan_item, attrs) do
    plan_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
