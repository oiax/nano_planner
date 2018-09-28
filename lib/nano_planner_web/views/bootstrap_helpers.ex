defmodule NanoPlannerWeb.BootstrapHelpers do
  import Phoenix.HTML.Form

  def bootstrap_text_input(form, field, opts \\ []) do
    class = form_control_class(form, field)
    opts = Keyword.put(opts, :class, class)

    text_input(form, field, opts)
  end

  defp form_control_class(form, field) do
    if Keyword.has_key?(form.errors, field) do
      "form-control is-invalid"
    else
      "form-control"
    end
  end
end
