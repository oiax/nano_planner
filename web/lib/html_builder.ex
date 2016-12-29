defmodule NanoPlanner.HtmlBuilder do
  import Phoenix.HTML, only: [html_escape: 1, safe_to_string: 1]
  import StringBuffer, only: [append: 2]

  defmacro markup(do: expression) do
    quote do
      {:ok, var!(buf, NanoPlanner.HtmlBuilder)} = StringBuffer.start_link

      unquote(expression)

      html_fragment = StringBuffer.get(var!(buf, NanoPlanner.HtmlBuilder))
      StringBuffer.stop(var!(buf, NanoPlanner.HtmlBuilder))
      {:safe, html_fragment}
    end
  end

  defmacro text(text) do
    quote do
      append var!(buf, NanoPlanner.HtmlBuilder), safe_to_string(html_escape(unquote(text)))
    end
  end

  defmacro raw_text(text) do
    quote do
      append var!(buf, NanoPlanner.HtmlBuilder), unquote(text)
    end
  end

  defmacro space do
    quote do
      append var!(buf, NanoPlanner.HtmlBuilder), " "
    end
  end

  defmacro new_line do
    quote do
      append var!(buf, NanoPlanner.HtmlBuilder), "\n"
    end
  end

  defmacro open_tag(tag_name, attributes) do
    parts = Enum.map attributes, fn({k, v}) ->
      if k == :data && is_list(v) do
        Enum.map v, fn({kk, vv}) ->
          kk = kk |> Atom.to_string |> String.replace("_", "-")
          vv = safe_to_string(html_escape(vv))
          "data-#{kk}='#{vv}'"
        end
      else
        v = safe_to_string(html_escape(v))
        "#{k}='#{v}'"
      end
    end
    attr = List.flatten(parts) |> Enum.join(" ")
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
        append var!(buf, NanoPlanner.HtmlBuilder), open_tag(unquote(tag_name), unquote(attributes))
        unquote(expression)
        append var!(buf, NanoPlanner.HtmlBuilder), close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(do: expression) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, NanoPlanner.HtmlBuilder), open_tag(unquote(tag_name), [])
        unquote(expression)
        append var!(buf, NanoPlanner.HtmlBuilder), close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(text, attributes) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, NanoPlanner.HtmlBuilder), open_tag(unquote(tag_name), unquote(attributes))
        text unquote(text)
        append var!(buf, NanoPlanner.HtmlBuilder), close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(text) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, NanoPlanner.HtmlBuilder), open_tag(unquote(tag_name), [])
        text unquote(text)
        append var!(buf, NanoPlanner.HtmlBuilder), close_tag(unquote(tag_name))
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
        append var!(buf, NanoPlanner.HtmlBuilder), open_tag(unquote(tag_name), unquote(attributes))
      end
    end
  end
end
