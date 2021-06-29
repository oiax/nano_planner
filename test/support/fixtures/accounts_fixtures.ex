defmodule NanoPlanner.AccountsFixtures do
  import NanoPlanner.Repo, only: [insert!: 1]
  alias NanoPlanner.Accounts.User

  def unique_login_name, do: "user#{System.unique_integer()}"

  def user_fixture(attrs \\ []) do
    login_name = Keyword.get(attrs, :login_name, unique_login_name())
    hashed_password = Bcrypt.hash_pwd_salt(login_name <> "123!")

    insert!(%User{
      login_name: login_name,
      hashed_password: hashed_password
    })
  end
end
