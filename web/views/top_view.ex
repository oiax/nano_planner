defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import Kernel, except: [div: 2]
  import NanoPlanner.HtmlBuilder

  markup :foo do
    div class: "foo" do
      span style: "font-size: 10px" do
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
