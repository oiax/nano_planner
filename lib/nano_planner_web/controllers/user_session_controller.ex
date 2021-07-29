defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller

  import NanoPlannerWeb.UserAuth,
    only: [redirect_if_user_is_authenticated: 2]

  plug :redirect_if_user_is_authenticated

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
