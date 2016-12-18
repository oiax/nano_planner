defmodule NanoPlanner.Repo.Migrations.CreatePlanItem do
  use Ecto.Migration

  def change do
    create table(:plan_items) do
      add :name, :string, null: false
      add :description, :string, size: 65535, null: false

      timestamps()
    end

  end
end
