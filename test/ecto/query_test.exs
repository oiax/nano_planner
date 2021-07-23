defmodule Ecto.QueryTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  describe "from/2" do
    test "キーワードクエリを作る" do
      user = user_fixture(login_name: "alice")

      query =
        from u in Accounts.User,
          where: [login_name: ^user.login_name]

      fetched = Repo.one(query)

      assert %Accounts.User{} = fetched
      assert fetched.id == user.id
    end
  end

  describe "join/5" do
    test "テーブル同士を連結する" do
      user1 = user_fixture(login_name: "alice")
      user2 = user_fixture(login_name: "bob")
      token1 = Accounts.generate_session_token(user1)
      _token2 = Accounts.generate_session_token(user2)

      query =
        from st in Accounts.SessionToken,
          where: [token: ^token1],
          join: u in assoc(st, :user),
          select: {%{st | user: u}, u}

      Logger.configure(level: :debug)

      {fetched1, fetched2} = Repo.one(query)

      assert %Accounts.SessionToken{} = fetched1
      assert fetched1.token == token1
      assert %Accounts.User{} = fetched1.user
      assert %Accounts.User{} = fetched2
      assert fetched2.id == user1.id
    end
  end
end
