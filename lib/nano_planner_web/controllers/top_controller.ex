defmodule NanoPlannerWeb.TopController do
  use NanoPlannerWeb, :controller

  def index(conn, _params) do
    if conn.assigns[:current_user] do
      render(conn, "index.html")
    else
      render(conn, "welcome.html")
    end
  end
end
