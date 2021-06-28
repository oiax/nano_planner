defmodule NanoPlanner.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :login_name, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
