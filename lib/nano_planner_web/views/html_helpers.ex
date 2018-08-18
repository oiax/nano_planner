defmodule NanoPlannerWeb.HtmlHelpers do
  def add_class(opts, new_class, true), do: add_class(opts, new_class)

  def add_class(opts, _new_class, false), do: opts

  def add_class(opts, new_class) do
    current_class = Keyword.get(opts, :class, "")

    class =
      if current_class == "" do
        new_class
      else
        current_class <> " " <> new_class
      end

    Keyword.put(opts, :class, class)
  end
end
