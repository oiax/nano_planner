defmodule NanoPlanner.ContextTest do
  use ExUnit.Case

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
end
