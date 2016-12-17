defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import Kernel, except: [div: 2]
  import NanoPlanner.HtmlBuilder

  markup :foo do
    div class: "fox'" do
      span style: "font-size: 10px" do
        text "AAA"
      end
      name = "ggg"
      div data: [ foo: 1, bar: "'" ] do
        if true do
          text "#{name}<br>"
        else
          text "FFF"
        end
      end
      new_line
      Enum.each ~w(aaa bbb), fn(x) ->
        div do
          span x
          space
          span "ZZZ"
        end
      end
      new_line
      raw_text("<hr>")
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
