defmodule Ecto.SchemaTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  setup do
    {:ok, user: user_fixture()}
  end

  describe "belongs/to" do
    test "初期化", %{user: user} do
      st1 = %Accounts.SessionToken{}
      st2 = %Accounts.SessionToken{user: user}

      assert %Ecto.Association.NotLoaded{} = st1.user
      assert %Accounts.User{} = st2.user
      assert is_nil(st2.user_id)
    end

    test "データベースへの挿入", %{user: user} do
      token = :crypto.strong_rand_bytes(32)
      st = Repo.insert!(%Accounts.SessionToken{token: token, user: user})

      assert %Accounts.User{} = st.user
      assert st.user_id == user.id
    end

    test "データベースから取得", %{user: user} do
      token = Accounts.generate_session_token(user)
      st = Repo.get_by(Accounts.SessionToken, token: token)

      assert %Ecto.Association.NotLoaded{} = st.user
      assert st.user_id == user.id
    end
  end
end
