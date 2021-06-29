defmodule NanoPlanner.AccountsTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts

  describe "count_users/0" do
    test "初期状態では0を返す" do
      assert Accounts.count_users() == 0
    end

    test "登録されているユーザーの数を返す" do
      import NanoPlanner.Repo, only: [insert!: 1]
      alias NanoPlanner.Accounts.User

      for login_name <- ~w(alice bob carol david eve) do
        hashed_password = Bcrypt.hash_pwd_salt(login_name <> "123!")

        insert!(%User{
          login_name: login_name,
          hashed_password: hashed_password
        })
      end

      assert Accounts.count_users() == 5
    end
  end
end
