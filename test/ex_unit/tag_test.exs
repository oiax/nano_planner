defmodule NanoPlanner.TagTest do
  use NanoPlanner.DataCase

  @tag login_name: "bob"
  test "ログイン名はbobである", %{user: user} do
    assert user.login_name == "bob"
  end

  setup context do
    number = if context[:set_number], do: 100
    {:ok, number: number}
  end

  @tag :set_number
  test "numberは整数である", %{number: number} do
    assert is_integer(number)
  end

  test "numberはnilである", %{number: number} do
    assert is_nil(number)
  end
end
