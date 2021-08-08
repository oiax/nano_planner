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

  describe "join/5" do
    test "テーブル結合" do
      user1 = user_fixture(login_name: "alice")
      user2 = user_fixture(login_name: "bob")
      token1 = Accounts.generate_session_token(user1)
      _token2 = Accounts.generate_session_token(user2)

      query =
        from t in Accounts.SessionToken,
          where: t.token == ^token1,
          join: u in Accounts.User,
          on: t.user_id == u.id,
          select: {t, u}

      {fetched1, fetched2} = Repo.one(query)

      assert %Accounts.SessionToken{} = fetched1
      assert %Accounts.User{} = fetched2
      assert fetched2.id == user1.id
    end
  end
end
