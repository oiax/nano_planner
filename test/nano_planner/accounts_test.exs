defmodule NanoPlanner.AccountsTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts

  describe "count_users/0" do
    test "初期状態では0を返す" do
      assert Accounts.count_users() == 0
    end

    test "登録されているユーザーの数を返す" do
      assert Accounts.count_users() == 5
    end
  end
end
