defmodule NanoPlannerWeb.HtmlHelpers do
  def add_class(_class_attr = "", new_class), do: new_class

  def add_class(_class_attr = "", new_class, bool) do
    if bool, do: new_class, else: ""
  end

  def add_class(class_attr, new_class), do: class_attr <> " " <> new_class

  def add_class(class_attr, new_class, bool) do
    if bool, do: class_attr <> " " <> new_class, else: class_attr
  end
end
