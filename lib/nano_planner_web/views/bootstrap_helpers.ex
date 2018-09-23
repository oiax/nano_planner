defmodule NanoPlannerWeb.BootstrapHelpers do
  def bootstrap_text_input(form, field, opts \\ []) do
    opts = Keyword.put(opts, :class, form_control_class(form, field, opts))

    Phoenix.HTML.Form.text_input(form, field, opts)
  end

  defp form_control_class(form, field, opts) do
    class = Keyword.get(opts, :class, "")

    class =
      if class == "" do
        class
      else
        class <> " " <> "form-control"
      end

    if Keyword.has_key?(form.errors, field) do
      class <> " " <> "is-invalid"
    else
      class
    end
  end
end
