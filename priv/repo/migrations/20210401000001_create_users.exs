defmodule NanoPlanner.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login_name, :string, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end

    create unique_index(:users, :login_name)
  end
end
