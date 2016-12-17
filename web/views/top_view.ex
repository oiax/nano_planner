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
        if true do
          text "XXX"
        else
          text "FFF"
        end
      end
      new_line
      div do
        span "YYY"
        space
        span "ZZZ"
      end
      new_line
      table do
        tr do
          th do
            text "vvv"
          end
        end
      end
    end
  end
end
