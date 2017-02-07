defmodule NanoPlanner.LessonsController do
  use NanoPlanner.Web, :controller

  def form(conn, _params) do
    render conn, "form.html"
  end

  def register(conn, params) do
    render conn, "register.html", user_name: params["user_name"]
  end
end
