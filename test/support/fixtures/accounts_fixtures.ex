defmodule NanoPlanner.AccountsFixtures do 
  import NanoPlanner.Repo, only: [insert!: 1]
  alias NanoPlanner.Accounts.User

  def user_fixture(attrs) do
    hashed_password = Bcrypt.hash_pwd_salt(attrs[:login_name] <> "123!")

    insert!(%User{
      login_name: attrs[:login_name],
      hashed_password: hashed_password
    })
  end
end
