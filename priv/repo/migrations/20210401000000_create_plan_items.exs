defmodule NanoPlanner.Repo.Migrations.CreatePlanItems do
  use Ecto.Migration

  def change do
    create table(:plan_items) do
      add :name, :string, null: false
      add :description, :text, null: false

      timestamps()
    end
  end
end
