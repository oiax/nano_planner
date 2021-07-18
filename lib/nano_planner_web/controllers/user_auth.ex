defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias NanoPlanner.Accounts
  alias NanoPlannerWeb.Router.Helpers, as: Routes

  def log_in_user(conn, user, _params \\ %{}) do
    token = Accounts.generate_session_token(user)

    conn
    |> configure_session(renew: true)
    |> clear_session()
    |> put_session(:session_token, token)
    |> redirect(to: "/")
  end

  def log_out_user(conn) do
    session_token = get_session(conn, :session_token)
    session_token && Accounts.delete_session_token(session_token)

    conn
    |> configure_session(renew: true)
    |> clear_session()
    |> redirect(to: "/")
  end

  def no_user_auth(conn, _opts) do
    assign(conn, :current_user, nil)
  end

  def fetch_current_user(conn, _opts) do
    session_token = get_session(conn, :session_token)
    user = session_token && Accounts.get_user_by_session_token(session_token)
    assign(conn, :current_user, user)
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
