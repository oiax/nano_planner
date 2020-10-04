defmodule NanoPlanner.Repo.Migrations.CreatePlanItems do
  use Ecto.Migration

  def change do
    create table(:plan_items) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :starts_at, :utc_datetime, null: false
      add :ends_at, :utc_datetime, null: false

      timestamps()
    end
  end
end
