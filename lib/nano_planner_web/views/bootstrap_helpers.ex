defmodule NanoPlannerWeb.BootstrapHelpers do
  import Phoenix.HTML.Form
  import Phoenix.HTML.Tag
  import NanoPlannerWeb.ErrorHelpers, only: [translate_error: 1]

  def bootstrap_text_input(form, field, opts \\ []) do
    class = form_control_class(form, field, opts)
    opts = Keyword.put(opts, :class, class)

    text_input(form, field, opts)
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
      content_tag(:div, translate_error(error), class: "invalid-feedback")
    end)
  end
end
