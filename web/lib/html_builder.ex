defmodule NanoPlanner.HtmlBuilder do
  defmacro markup(fn_name, do: expression) do
    quote do
      def unquote(fn_name)(var!(acc) \\ "") do
        unquote(expression)
        var!(acc)
      end
    end
  end

  defmacro text(text) do
    quote do
      var!(acc) = var!(acc) <> unquote(text)
    end
  end

  defmacro open_tag(tag_name, attributes) do
    attr = Enum.map(attributes, fn({k, v}) -> "#{k}='#{v}'" end) |> Enum.join(" ")
    case attr do
      "" -> "<#{tag_name}>"
      _ ->  "<#{tag_name} " <> attr <> ">"
    end
  end

  defmacro close_tag(tag_name) do
    "</#{tag_name}>"
  end

  tag_names = ~W(div span)a

  for tag_name <- tag_names do
    defmacro unquote(tag_name)(attributes \\ [], do: expression) do
      tag_name = unquote(tag_name)
      quote do
        var!(acc) = var!(acc) <> open_tag(unquote(tag_name), unquote(attributes))
        unquote(expression)
        var!(acc) = var!(acc) <> close_tag(unquote(tag_name))
      end
    end
  end
end
