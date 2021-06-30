defmodule NanoPlanner.AccountsTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  describe "count_users/0" do
    test "初期状態では0を返す" do
      assert Accounts.count_users() == 0
    end

    test "登録されているユーザーの数を返す" do
      for _i <- 1..5 do
        %Accounts.User{} = user_fixture()
      end

      assert Accounts.count_users() == 5
    end
  end

  describe "get_user_by_login_name_and_password/2" do
    test "ログイン名が存在しない場合はユーザーを返さない" do
      fetched =
        Accounts.get_user_by_login_name_and_password(
          "unknown",
          "unknown123!"
        )

      assert fetched == nil
    end

    test "パスワードが正しくなければユーザーを返さない" do
      user = user_fixture(login_name: "alice")

      fetched =
        Accounts.get_user_by_login_name_and_password(
          user.login_name,
          "invalid"
        )

      assert fetched == nil
    end

    test "ログイン名とパスワードが正しければユーザーを返す" do
      user = user_fixture(login_name: "alice")

      fetched =
        Accounts.get_user_by_login_name_and_password("alice", "alice123!")

      assert %Accounts.User{} = fetched
      assert fetched.id == user.id
    end
  end

  describe "generate_user_session_token/1" do
    setup do
      %{user: user_fixture()}
    end

    test "トークンを生成する", %{user: user} do
      token = Accounts.generate_user_session_token(user)
      assert user_token = Repo.get_by(Accounts.UserToken, token: token)
      assert user_token.context == "session"

      assert_raise Ecto.ConstraintError, fn ->
        Repo.insert!(%Accounts.UserToken{
          token: user_token.token,
          user_id: user_fixture().id,
          context: "session"
        })
      end
    end
  end

  describe "get_user_by_session_token/1" do
    setup do
      user = user_fixture()
      token = Accounts.generate_user_session_token(user)
      %{user: user, token: token}
    end

    test "トークンを所有するユーザーを返す", %{user: user, token: token} do
      assert session_user = Accounts.get_user_by_session_token(token)
      assert session_user.id == user.id
    end

    test "存在しないトークンを渡すとnilを返す" do
      assert Accounts.get_user_by_session_token("oops") == nil
    end
  end

  describe "delete_session_token/1" do
    test "トークンを削除する" do
      user = user_fixture()
      token = Accounts.generate_user_session_token(user)
      assert Accounts.delete_session_token(token) == :ok
      assert Accounts.get_user_by_session_token(token) == nil
    end
  end
end
