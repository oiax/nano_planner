defmodule NanoPlanner.Accounts do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Accounts.{User, UserToken}

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

  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  def get_user_by_session_token(token) do
    query =
      from ut in UserToken,
        where: [token: ^token, context: "session"],
        join: user in assoc(ut, :user),
        select: user

    Repo.one(query)
  end
end
