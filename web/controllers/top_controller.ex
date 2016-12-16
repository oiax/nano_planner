defmodule NanoPlanner.TopController do
  use NanoPlanner.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
