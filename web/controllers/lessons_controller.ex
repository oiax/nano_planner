defmodule NanoPlanner.LessonsController do
  use NanoPlanner.Web, :controller

  def form(conn, _params) do
    render conn, "form.html"
  end
end
