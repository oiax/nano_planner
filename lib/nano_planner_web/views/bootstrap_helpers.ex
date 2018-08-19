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
      attribute = feedback_attribute(form, field)
      message = translate_error(error)
      full_message = feedback_full_message(attribute, message)
      content_tag(:div, full_message, opts)
    end)
  end

  defp feedback_attribute(form, field) do
    Gettext.dgettext(
      NanoPlannerWeb.Gettext,
      "schema",
      "#{form.name}|#{field}"
    )
  end

  defp feedback_full_message(attribute, message) do
    Gettext.dgettext(
      NanoPlannerWeb.Gettext,
      "errors",
      "%{attribute} %{message}.",
      attribute: attribute,
      message: message
    )
  end
end
