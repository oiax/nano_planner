defmodule NanoPlannerWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML
  require NanoPlannerWeb.Gettext

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      attribute = feedback_attribute(form, field)
      message = translate_error(error)
      full_message = feedback_full_message(attribute, message)

      content_tag(:div, full_message,
        class: "invalid-feedback",
        phx_feedback_for: input_name(form, field)
      )
    end)
  end

  defp feedback_attribute(form, field) do
    Gettext.dgettext(
      NanoPlannerWeb.Gettext,
      form.name,
      Phoenix.Naming.humanize(field)
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

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(NanoPlannerWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(NanoPlannerWeb.Gettext, "errors", msg, opts)
    end
  end
end
