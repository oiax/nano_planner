defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import NanoPlanner.HtmlBuilder

  markup :foo do
    div do
      span do
        text "AAA"
      end
      div do
        text "XXX"
      end
      div do
        span do
          text "YYY"
        end
        span do
          text "ZZZ"
        end
      end
    end
  end
end
