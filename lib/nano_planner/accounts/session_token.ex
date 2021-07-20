defmodule NanoPlanner.Accounts.SessionToken do
  use Ecto.Schema
  alias NanoPlanner.Accounts.User

  @rand_size 32

  schema "session_tokens" do
    belongs_to :user, User
    field :token, :binary

    timestamps(type: :utc_datetime_usec, updated_at: false)
  end

  def build_session_token(%User{} = user) do
    token = :crypto.strong_rand_bytes(@rand_size)
    {token, %__MODULE__{token: token, user_id: user.id}}
  end
end
