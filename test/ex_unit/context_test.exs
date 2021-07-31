defmodule NanoPlanner.ContextTest do
  use NanoPlanner.DataCase
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  setup do
    {:ok, number: 100}
  end

  setup do
    {:ok, message: "Hello"}
  end

  test "コンテキストからnumberを取得する", %{number: number} do
    assert number == 100
  end

  test "コンテキストからmessageを取得する", %{message: message} do
    assert message == "Hello"
  end

  test "コンテキストを取得する", context do
    assert context[:number] == 100
    assert context[:message] == "Hello"
  end

  describe "Accounts.get_user_by_login_name_and_password/2" do
    setup do
      user_fixture(login_name: "taro")
      :ok
    end

    test "ユーザーを返す" do
      u = Accounts.get_user_by_login_name_and_password("taro", "taro123!")
      assert %Accounts.User{} = u
    end
  end
end
