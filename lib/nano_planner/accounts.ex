defmodule NanoPlanner.Accounts do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo
  alias NanoPlanner.Accounts.User

  def count_users do
    Repo.aggregate(User, :count, :id)
  end
end
