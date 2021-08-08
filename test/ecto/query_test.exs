defmodule Ecto.QueryTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  describe "from/2" do
    test "ユーザーを取得" do
      user = user_fixture(login_name: "alice")

      query =
        from u in Accounts.User,
          where: [login_name: ^user.login_name]

      fetched = Repo.one(query)

      assert %Accounts.User{} = fetched
      assert fetched.id == user.id
    end
  end
end
