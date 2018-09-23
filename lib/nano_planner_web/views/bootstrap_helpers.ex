defmodule NanoPlannerWeb.BootstrapHelpers do
  def bootstrap_text_input(form, field, opts \\ []) do
    opts = Keyword.put(opts, :class, form_control_class(form, field, opts))

    Phoenix.HTML.Form.text_input(form, field, opts)
  end

  defp form_control_class(form, field, opts) do
    opts
    |> Keyword.get(:class, "")
    |> add_class("form-control")
    |> add_class("is-invalid", Keyword.has_key?(form.errors, field))
  end

  defp add_class(class, new_class) do
    if class == "" do
      new_class
    else
      class <> " " <> new_class
    end
  end

  defp add_class(class, new_class, true), do: add_class(class, new_class)

  defp add_class(class, new_class, false), do: class
end
