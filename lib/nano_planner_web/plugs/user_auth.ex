defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]
  alias NanoPlannerWeb.Router.Helpers, as: Routes

  def redirect_if_user_is_authenticated(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
      |> redirect(to: Routes.top_path(conn, :index))
      |> halt()
    else
      conn
    end
  end

  def require_authenticated_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> redirect(to: Routes.user_session_path(conn, :new))
      |> halt()
    end
  end
end
