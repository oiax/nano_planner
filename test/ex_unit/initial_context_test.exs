defmodule NanoPlanner.InitialContextTest do
  use ExUnit.Case

  describe "コンテキスト" do
    test "初期状態", context do
      assert context[:module] == NanoPlanner.InitialContextTest
    end
  end
end
