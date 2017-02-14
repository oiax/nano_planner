defmodule NanoPlanner.LayoutView do
  use NanoPlanner.Web, :view

  def document_title(view_module, view_template, assigns) do
    if function_exported?(view_module, :document_title, 2) do
      view_module.document_title(view_template, assigns)
    else
      "NanoPlanner"
    end
  end
end
