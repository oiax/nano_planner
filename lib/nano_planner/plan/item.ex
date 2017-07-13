defmodule NanoPlanner.Plan.Item do
  use Ecto.Schema
  use Timex.Ecto.Timestamps

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, Timex.Ecto.DateTime
    field :ends_at, Timex.Ecto.DateTime

    timestamps()
  end
end
