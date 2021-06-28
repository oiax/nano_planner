defmodule NanoPlanner.Accounts do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Accounts.User

  def count_users do
    Repo.aggregate(User, :count, :id)
  end

  def get_user_by_login_name_and_password(login_name, password)
      when is_binary(login_name) and is_binary(password) do
    user = Repo.get_by(User, login_name: login_name)
    if User.valid_password?(user, password), do: user
  end
end
