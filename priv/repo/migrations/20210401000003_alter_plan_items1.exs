defmodule NanoPlanner.Repo.Migrations.AlterPlanItems1 do
  use Ecto.Migration

  def change do
    alter table(:plan_items) do
      add :owner_id, references(:users, on_delete: :delete_all), null: false
    end
  end
end
