defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import Kernel, except: [div: 2]
  import NanoPlanner.HtmlBuilder
  require Logger

  def xyz do
    {:ok, buf} = StringBuffer.start_link
    markup do
      div class: "fox" do
        span "Bar"
      end
      for x <- ~w(aaa bbb) do
        div x
        div "b"
        for y <- ~w(ccc ddd) do
          span y
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
end
