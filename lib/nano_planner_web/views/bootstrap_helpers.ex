defmodule NanoPlannerWeb.BootstrapHelpers do
  use Phoenix.HTML
  import NanoPlannerWeb.HtmlHelpers, only: [add_class: 2, add_class: 3]
  import NanoPlannerWeb.ErrorHelpers, only: [translate_error: 1]

  def bootstrap_text_input(form, field, opts \\ []) do
    opts =
      opts
      |> add_class("form-control")
      |> add_class("is-invalid", Keyword.has_key?(form.errors, field))

    Phoenix.HTML.Form.text_input(form, field, opts)
  end

  def bootstrap_feedback(form, field, opts \\ []) do
    opts =
      opts
      |> add_class("invalid-feedback", Keyword.has_key?(form.errors, field))

    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      subject =
        Gettext.dgettext(
          NanoPlannerWeb.Gettext,
          "schema",
          "plan_item|#{field}"
        )

      predicate = translate_error(error)

      message =
        Gettext.dgettext(
          NanoPlannerWeb.Gettext,
          "errors",
          "%{subject} %{predicate}.",
          subject: subject,
          predicate: predicate
        )

      content_tag(:div, message, opts)
    end)
  end
end
