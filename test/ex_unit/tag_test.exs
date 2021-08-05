defmodule NanoPlanner.TagTest do
  use NanoPlanner.DataCase

  @tag :login
  @tag login_name: "bob"
  test "ログイン名はbobである", %{user: user} do
    assert user.login_name == "bob"
  end

  @tag :login
  @tag test_type: :foo
  test "ログイン名はaliceである", %{user: user} do
    assert user.login_name == "alice"
  end
end
