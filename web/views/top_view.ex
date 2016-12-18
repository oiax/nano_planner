defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import XmlBuilder, only: [generate: 1]

  def foo do
    {
      :div, %{class: "foo"}, [
        {:span, nil, "A" },
        {:span, nil, "B" }
      ]
    } |> generate
  end
end
