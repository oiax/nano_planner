defmodule NanoPlannerWeb.BootstrapHelpers do
  import Phoenix.HTML.Form

  def bootstrap_text_input(form, field, opts \\ []) do
    class = form_control_class(form, field, opts)
    opts = Keyword.put(opts, :class, class)

    text_input(form, field, opts)
  end

  defp form_control_class(form, field, opts) do
    class = Keyword.get(opts, :class, "")

    class =
      if class == "" do
        class <> "form-control"
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
