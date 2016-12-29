defmodule NanoPlanner.HtmlBuilder do

  import Phoenix.HTML, only: [html_escape: 1, safe_to_string: 1]
  import StringBuffer, only: [append: 2]

  @external_resource normal_tag_names_path =
    Path.join([__DIR__, "normal_tag_names.txt"])
  @external_resource void_tag_names_path =
    Path.join([__DIR__, "void_tag_names.txt"])

  @normal_tag_names (
    for line <- File.stream!(normal_tag_names_path, [], :line) do
      line |> String.strip |> String.to_atom
    end
  )
  @void_tag_names (
    for line <- File.stream!(void_tag_names_path, [], :line) do
      line |> String.strip |> String.to_atom
    end
  )

  defmacro __using__(_) do
    quote do
      import Kernel, except: [div: 2]
      import NanoPlanner.HtmlBuilder
    end
  end

  defmacro markup(do: expression) do
    quote do
      {:ok, var!(buf, HtmlBuilder)} = StringBuffer.start_link

      unquote(expression)

      html_fragment = StringBuffer.get(var!(buf, HtmlBuilder))
      StringBuffer.stop(var!(buf, HtmlBuilder))
      {:safe, html_fragment}
    end
  end

  defmacro text(text) do
    quote do
      append var!(buf, HtmlBuilder), safe_to_string(html_escape(unquote(text)))
    end
  end

  defmacro raw_text(text) do
    quote do
      append var!(buf, HtmlBuilder), unquote(text)
    end
  end

  defmacro space do
    quote do
      append var!(buf, HtmlBuilder), " "
    end
  end

  defmacro new_line do
    quote do
      append var!(buf, HtmlBuilder), "\n"
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

  for tag_name <- @normal_tag_names do
    defmacro unquote(tag_name)(attributes, do: expression) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, HtmlBuilder), open_tag(unquote(tag_name), unquote(attributes))
        unquote(expression)
        append var!(buf, HtmlBuilder), close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(do: expression) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, HtmlBuilder), open_tag(unquote(tag_name), [])
        unquote(expression)
        append var!(buf, HtmlBuilder), close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(text, attributes) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, HtmlBuilder), open_tag(unquote(tag_name), unquote(attributes))
        text unquote(text)
        append var!(buf, HtmlBuilder), close_tag(unquote(tag_name))
      end
    end

    defmacro unquote(tag_name)(text) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, HtmlBuilder), open_tag(unquote(tag_name), [])
        text unquote(text)
        append var!(buf, HtmlBuilder), close_tag(unquote(tag_name))
      end
    end
  end

  for tag_name <- @void_tag_names do
    defmacro unquote(tag_name)(attributes \\ []) do
      tag_name = unquote(tag_name)
      quote do
        append var!(buf, HtmlBuilder), open_tag(unquote(tag_name), unquote(attributes))
      end
    end
  end
end
