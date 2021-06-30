defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias NanoPlanner.Accounts

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
end
