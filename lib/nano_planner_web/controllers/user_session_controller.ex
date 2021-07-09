defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
