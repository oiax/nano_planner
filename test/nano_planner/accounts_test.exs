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

  describe "generate_session_token/1" do
    test "セッショントークンを生成する" do
      user = user_fixture()
      token = Accounts.generate_session_token(user)

      assert is_binary(token)
      assert byte_size(token) == 32
    end

    test "session_tokensテーブルに正しくレコードが挿入される" do
      user = user_fixture()
      token = Accounts.generate_session_token(user)

      session_token = Repo.get_by(Accounts.SessionToken, token: token)

      assert session_token != nil
      assert session_token.user_id == user.id
    end
  end

  describe "get_user_by_session_token/1" do
    test "セッショントークンの所有者であるユーザーを返す" do
      user = user_fixture()
      token = Accounts.generate_session_token(user)

      session_owner = Accounts.get_user_by_session_token(token)

      assert %Accounts.User{} = session_owner
      assert session_owner.id == user.id
    end

    test "存在しないセッショントークンを渡すとnilを返す" do
      assert Accounts.get_user_by_session_token("oops") == nil
    end
  end

  describe "delete_session_token/1" do
    test "セッショントークンを削除する" do
      user = user_fixture()
      token = Accounts.generate_session_token(user)

      assert Accounts.delete_session_token(token) == :ok
      assert Accounts.get_user_by_session_token(token) == nil
    end
  end
end
