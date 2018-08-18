defmodule NanoPlannerWeb.BootstrapHelpers do
  import NanoPlannerWeb.HtmlHelpers, only: [add_class: 2, add_class: 3]

  def bootstrap_text_input(form, field, opts \\ []) do
    class_attr =
      Keyword.get(opts, :class, "")
      |> add_class("form-control")
      |> add_class("is-invalid", Keyword.has_key?(form.errors, field))

    opts = Keyword.put(opts, :class, class_attr)
    Phoenix.HTML.Form.text_input(form, field, opts)
  end
end
