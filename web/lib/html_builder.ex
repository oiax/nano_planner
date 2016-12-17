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

  defmacro div(_opts \\ [], do: expression) do
    quote do
      var!(acc) = var!(acc) <> "<div>"
      unquote(expression)
      var!(acc) = var!(acc) <> "</div>"
    end
  end

  defmacro span(_opts \\ [], do: expression) do
    quote do
      var!(acc) = var!(acc) <> "<span>"
      unquote(expression)
      var!(acc) = var!(acc) <> "</span>"
    end
  end
end
