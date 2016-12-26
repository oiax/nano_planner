defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  use Marker

  template :foo do
    div do
      for item <- @list do
        span item, class: "item"
      end
      " K"
      @foo
    end
  end
end
