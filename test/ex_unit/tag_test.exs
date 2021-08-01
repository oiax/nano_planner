defmodule NanoPlanner.TagTest do
  use NanoPlanner.DataCase, async: true

  @tag :login
  @tag login_name: "bob"
  test "ログイン名はbobである", %{user: user} do
    assert user.login_name == "bob"
  end
end
