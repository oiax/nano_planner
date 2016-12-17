defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import Kernel, except: [div: 2]
  import NanoPlanner.HtmlBuilder
  require Logger

  markup :foo do
    div class: "fox'" do
      # span style: "font-size: 10px" do
      #   text "AAA"
      # end
      # name = "ggg"
      # div data: [ foo: 1, bar: "'" ] do
      #   if name == "ggg" do
      #     text "#{name}<br>"
      #   else
      #     text "FFF"
      #   end
      # end
      # new_line
      for_each ~w(aaa bbb), fn(x) ->
        div do
          span x
          space
          span "ZZZ"
        end
        for_each ~w(ccc ddd), fn(x) ->
          div do
            span x
            space
            span "QQQ"
          end
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
