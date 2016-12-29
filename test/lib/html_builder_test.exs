defmodule NanoPlanner.HtmlBuilderTest do
  use ExUnit.Case

  test "first" do
    use NanoPlanner.HtmlBuilder

    html = markup do
      div class: "x" do
        span "Foo"
      end
      text "Bar"
      br
    end

    assert html == {:safe, "<div class='x'><span>Foo</span></div>Bar<br>"}
  end
end
