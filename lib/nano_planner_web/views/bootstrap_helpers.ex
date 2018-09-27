defmodule NanoPlannerWeb.BootstrapHelpers do
  use Phoenix.HTML
  import NanoPlannerWeb.ErrorHelpers, only: [translate_error: 1]
  import NanoPlannerWeb.Gettext

  def bootstrap_text_input(form, field, opts \\ []) do
    class = form_control_class(form, field, opts)
    opts = Keyword.put(opts, :class, class)

    Phoenix.HTML.Form.text_input(form, field, opts)
  end

  def bootstrap_textarea(form, field, opts \\ []) do
    class = form_control_class(form, field, opts)
    opts = Keyword.put(opts, :class, class)

    Phoenix.HTML.Form.textarea(form, field, opts)
  end

  defp form_control_class(form, field, opts) do
    opts
    |> Keyword.get(:class, "")
    |> add_class("form-control")
    |> add_class("is-invalid", Keyword.has_key?(form.errors, field))
  end

  defp add_class("" = _class, new_class), do: new_class
  defp add_class(class, new_class), do: class <> " " <> new_class
  defp add_class(class, new_class, true), do: add_class(class, new_class)
  defp add_class(class, _new_class, false), do: class

  def bootstrap_feedback(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      attribute = feedback_attribute(form, field)
      message = translate_error(error)
      full_message = feedback_full_message(attribute, message)
      content_tag(:div, full_message, class: "invalid-feedback")
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
    NanoPlannerWeb.Gettext.dgettext(
      "errors",
      "%{attribute} %{message}.",
      attribute: attribute,
      message: message
    )
  end

  def boostrap_custom_checkbox(form, field, label_text) do
    content_tag(:div, class: "custom-control custom-checkbox") do
      [
        checkbox(form, field, class: "custom-control-input"),
        label(form, field, label_text, class: "custom-control-label")
      ]
    end
  end
end
