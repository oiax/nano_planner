defmodule NanoPlanner.Accounts do
  import Ecto.Query
  alias NanoPlanner.Repo
  alias NanoPlanner.Accounts.{User, SessionToken}

  def count_users do
    Repo.aggregate(User, :count, :id)
  end

  def get_user_by_login_name_and_password(login_name, password) do
    user = Repo.get_by(User, login_name: login_name)

    if user do
      if Bcrypt.verify_pass(password, user.hashed_password), do: user
    else
      Bcrypt.no_user_verify()
      nil
    end
  end

  @rand_size 32

  def generate_session_token(%User{} = user) do
    token = :crypto.strong_rand_bytes(@rand_size)
    Repo.insert!(%SessionToken{token: token, user_id: user.id})
    token
  end

  def get_user_by_session_token(token) do
    query =
      from t in SessionToken,
        where: t.token == ^token,
        join: user in User,
        on: t.user_id == user.id,
        select: user

    Repo.one(query)
  end

  def delete_session_token(token) do
    SessionToken
    |> where(token: ^token)
    |> Repo.delete_all()

    :ok
  end
end
