defmodule NanoPlanner.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset, warn: false

  schema "users" do
    field :login_name, :string
    field :hashed_password, :string, redact: true

    timestamps(type: :utc_datetime_usec)
  end

  def valid_password?(
        %__MODULE__{hashed_password: hashed_password},
        password
      )
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end
end
