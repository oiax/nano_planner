defmodule NanoPlanner.Accounts.User do
  use Ecto.Schema

  schema "users" do
    field :login_name, :string
    field :hashed_password, :string, redact: true

    timestamps(type: :utc_datetime_usec)
  end
end
