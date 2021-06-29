defmodule NanoPlanner.AccountsTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  describe "count_users/0" do
    test "初期状態では0を返す" do
      assert Accounts.count_users() == 0
    end

    test "登録されているユーザーの数を返す" do
      for login_name <- ~w(alice bob carol david eve) do
        %Accounts.User{} = user_fixture(login_name: login_name)
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
end
