defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias NanoPlanner.Accounts

  def log_in_user(conn, user, _params \\ %{}) do
    token = Accounts.generate_user_session_token(user)

    conn
    |> configure_session(renew: true)
    |> put_session(:user_token, token)
    |> redirect(to: "/")
  end
end
