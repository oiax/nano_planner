defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import Kernel, except: [div: 2]
  import NanoPlanner.HtmlBuilder
  require Logger

  markup :xyz do
    div class: "fox" do
      span "Bar"
    end
    for x <- ~w(aaa bbb) do
      div x, data: [foo_bar: 1]
      div "b"
      for y <- ~w(ccc ddd) do
        span y
        br
      end
    end
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
