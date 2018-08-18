defmodule NanoPlannerWeb.BootstrapHelpers do
  use Phoenix.HTML
  import NanoPlannerWeb.HtmlHelpers, only: [add_class: 2, add_class: 3]
  import NanoPlannerWeb.ErrorHelpers, only: [translate_error: 1]

  def bootstrap_text_input(form, field, opts \\ []) do
    class_attr =
      Keyword.get(opts, :class, "")
      |> add_class("form-control")
      |> add_class("is-invalid", Keyword.has_key?(form.errors, field))

    opts = Keyword.put(opts, :class, class_attr)
    Phoenix.HTML.Form.text_input(form, field, opts)
  end

  def bootstrap_feedback(form, field, opts \\ []) do
    class_attr =
      Keyword.get(opts, :class, "")
      |> add_class("invalid-feedback", Keyword.has_key?(form.errors, field))

    opts = Keyword.put(opts, :class, class_attr)

    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:div, translate_error(error), opts)
    end)
  end
end
