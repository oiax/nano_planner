defmodule NanoPlanner.Accounts.UserToken do
  use Ecto.Schema
  import Ecto.Changeset, warn: false
  alias NanoPlanner.Accounts.User

  @rand_size 32

  schema "users_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime_usec, updated_at: false)
  end

  def build_session_token(%User{} = user) do
    token = :crypto.strong_rand_bytes(@rand_size)
    {token, %__MODULE__{token: token, context: "session", user_id: user.id}}
  end
end
