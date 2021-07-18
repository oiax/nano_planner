defmodule NanoPlanner.Repo.Migrations.CreateSessionTokens do
  use Ecto.Migration

  def change do
    create table(:session_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false

      timestamps(updated_at: false)
    end

    create index(:session_tokens, [:user_id])
    create unique_index(:session_tokens, [:token])
  end
end
