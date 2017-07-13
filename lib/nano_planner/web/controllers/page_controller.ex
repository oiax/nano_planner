defmodule NanoPlanner.Web.PageController do
  use NanoPlanner.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
