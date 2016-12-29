defmodule NanoPlanner.HtmlBuilderTest do
  use ExUnit.Case

  test "first" do
    import NanoPlanner.HtmlBuilder

    html = markup do
      div do
        span "Foo"
      end
    end

    assert html == {:safe, "<div><span>Foo</span></div>"}
  end
end
