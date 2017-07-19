defmodule NanoPlanner.Calendar.PlanItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias NanoPlanner.Calendar.PlanItem

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, Timex.Ecto.DateTime
    field :ends_at, Timex.Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
