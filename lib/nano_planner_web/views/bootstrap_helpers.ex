defmodule NanoPlannerWeb.BootstrapHelpers do
  use Phoenix.HTML
  import NanoPlannerWeb.HtmlHelpers, only: [add_class: 2, add_class: 3]
  import NanoPlannerWeb.ErrorHelpers, only: [translate_error: 1]

  def bootstrap_text_input(form, field, opts \\ []) do
    opts = add_form_control_classes(form, field, opts)
    Phoenix.HTML.Form.text_input(form, field, opts)
  end

  def bootstrap_date_input(form, field, opts \\ []) do
    opts = add_form_control_classes(form, field, opts)
    Phoenix.HTML.Form.date_input(form, field, opts)
  end

  def bootstrap_textarea(form, field, opts \\ []) do
    opts = add_form_control_classes(form, field, opts)
    Phoenix.HTML.Form.textarea(form, field, opts)
  end

  def bootstrap_select(form, field, options, opts \\ []) do
    opts = add_form_control_classes(form, field, opts)
    Phoenix.HTML.Form.select(form, field, options, opts)
  end

  defp add_form_control_classes(form, field, opts) do
    invalid =
      Keyword.has_key?(form.errors, field) ||
        Keyword.has_key?(form.errors, opts[:parent])

    opts
    |> Keyword.delete(:parent)
    |> add_class("form-control")
    |> add_class("is-invalid", invalid)
  end

  def boostrap_custom_checkbox(form, field, label_text) do
    content_tag(:div, class: "custom-control custom-checkbox") do
      [
        checkbox(form, field, class: "custom-control-input"),
        label(form, field, label_text, class: "custom-control-label")
      ]
    end
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
