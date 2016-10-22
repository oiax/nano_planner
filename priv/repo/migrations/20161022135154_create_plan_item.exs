defmodule NanoPlanner.Repo.Migrations.CreatePlanItem do
  use Ecto.Migration

  def change do
    create table(:plan_items) do
      add :name, :string
      add :description, :string, size: 65535

      timestamps()
    end

  end
end
