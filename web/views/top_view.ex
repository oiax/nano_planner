defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view

  def foo do
    {"div", [{:class, "x 1"}, {:"data-foo", "y"}], [
      {"span", nil, "Hello"},
      {"br"},
      {"br"},
      {"span", nil, "World!"}
    ]} |> HTMLBuilder.encode!(pretty: true)
  end
end
