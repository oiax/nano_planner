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
end
