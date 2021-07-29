defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]
  alias NanoPlanner.Accounts
  alias NanoPlannerWeb.Router.Helpers, as: Routes

  def fetch_current_user(conn, _opts) do
    session_token = get_session(conn, :session_token)

    if session_token do
      user = Accounts.get_user_by_session_token(session_token)
      assign(conn, :current_user, user)
    else
      conn
    end
  end

  def redirect_if_user_is_authenticated(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
      |> redirect(to: Routes.top_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end
