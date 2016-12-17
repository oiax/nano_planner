defmodule NanoPlanner.HtmlBuilder do
  defmacro markup(fn_name, do: expression) do
    quote do
      def unquote(fn_name)(var!(acc) \\ "") do
        unquote(expression)
        {:safe, var!(acc)}
      end
    end
  end

  defmacro text(text) do
    quote do
      var!(acc) = var!(acc) <> unquote(text)
    end
  end

  defmacro space do
    quote do
      var!(acc) = var!(acc) <> " "
    end
  end

  defmacro new_line do
    quote do
      var!(acc) = var!(acc) <> "\n"
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

  normal_tag_names = ~W(
    a abbr address article aside audio b bdi bdo
    blockquote body button canvas caption cite code
    colgroup datalist dd del details dfn dialog div
    dl dt em fieldset figcaption figure footer
    form h1 h2 h3 h4 h5 h6 head header html
    i iframe ins kbd label legend li main map mark
    menu menuitem meter nav noscript object ol optgroup
    option output p pre progress q rp rt ruby s
    samp script section select small span strong style
    sub summary sup table tbody td textarea tfoot
    th thead time title tr u ul var video
  )a

  for tag_name <- normal_tag_names do
    defmacro unquote(tag_name)(attributes, do: expression) do
      tag_name = unquote(tag_name)
      quote do
        var!(acc) = var!(acc) <> open_tag(unquote(tag_name), unquote(attributes))
        unquote(expression)
        var!(acc) = var!(acc) <> close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(do: expression) do
      tag_name = unquote(tag_name)
      quote do
        var!(acc) = var!(acc) <> open_tag(unquote(tag_name), [])
        unquote(expression)
        var!(acc) = var!(acc) <> close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(text, attributes) do
      tag_name = unquote(tag_name)
      quote do
        var!(acc) = var!(acc) <> open_tag(unquote(tag_name), unquote(attributes))
        text unquote(text)
        var!(acc) = var!(acc) <> close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(text) do
      tag_name = unquote(tag_name)
      quote do
        var!(acc) = var!(acc) <> open_tag(unquote(tag_name), [])
        text unquote(text)
        var!(acc) = var!(acc) <> close_tag(unquote(tag_name))
      end
    end
  end

  void_tag_names = ~W(
    area base br col embed hr img input keygen
    link meta param source track wbr
  )a

  for tag_name <- void_tag_names do
    defmacro unquote(tag_name)(attributes \\ []) do
      tag_name = unquote(tag_name)
      quote do
        var!(acc) = var!(acc) <> open_tag(unquote(tag_name), unquote(attributes))
      end
    end
  end
end
