defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  import HTMLBuilder, only: [encode!: 1]

  def foo(args) do
    attr = []
    attr = [{:"data-foo", "y"}|attr]
    if true do
      attr = [{:class, "btn btn-primary"}|attr]
    end
    {"div", attr, span_list(args)} |> encode! |> raw
  end

  defp span_list(args) do
    [
      {"div", [style: "color: red"], "Hello"},
      {"div", nil, "World!"}
    ] ++ Enum.map(args, fn(e) -> {"div", nil, e} end)
  end
end
