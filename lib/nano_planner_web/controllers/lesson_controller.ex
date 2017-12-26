defmodule NanoPlannerWeb.LessonController do
  use NanoPlannerWeb, :controller

  def form(conn, _params) do
    render conn, "form.html"
  end
end
