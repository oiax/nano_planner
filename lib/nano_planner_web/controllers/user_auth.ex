defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias NanoPlanner.Accounts
  alias NanoPlannerWeb.Router.Helpers, as: Routes

  def log_in_user(conn, user, _params \\ %{}) do
    token = Accounts.generate_user_session_token(user)

    conn
    |> configure_session(renew: true)
    |> clear_session()
    |> put_session(:user_token, token)
    |> redirect(to: "/")
  end

  def log_out_user(conn) do
    user_token = get_session(conn, :user_token)
    user_token && Accounts.delete_session_token(user_token)

    conn
    |> configure_session(renew: true)
    |> clear_session()
    |> redirect(to: "/")
  end

  def no_user_auth(conn, _opts) do
    assign(conn, :current_user, nil)
  end

  def fetch_current_user(conn, _opts) do
    user_token = get_session(conn, :user_token)
    user = user_token && Accounts.get_user_by_session_token(user_token)
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
