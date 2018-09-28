defmodule NanoPlannerWeb.BootstrapHelpers do
  def form_control_class(form, field) do
    if Keyword.has_key?(form.errors, field) do
      "form-control is-invalid"
    else
      "form-control"
    end
  end
end
