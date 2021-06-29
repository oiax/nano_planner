defmodule NanoPlanner.Accounts.UserToken do
  use Ecto.Schema
  import Ecto.Changeset, warn: false

  schema "user_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    belongs_to :user, NanoPlanner.Accounts.User

    timestamps()
  end
end
