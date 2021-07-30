defmodule NanoPlanner.TagTest do
  use NanoPlanner.DataCase
  import NanoPlanner.AccountsFixtures

  setup context do
    login_name = context[:login_name] || "alice"
    user = user_fixture(login_name: login_name)
    {:ok, user: user}
  end

  @tag login_name: "bob"
  test "ログイン名はbobである", %{user: user} do
    assert user.login_name == "bob"
  end
end
