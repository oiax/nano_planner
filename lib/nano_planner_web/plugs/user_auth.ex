defmodule NanoPlannerWeb.UserAuth do
  import Plug.Conn
  alias NanoPlanner.Accounts

  def fetch_current_user(conn, _opts) do
    session_token = get_session(conn, :session_token)
    user = session_token && Accounts.get_user_by_session_token(session_token)
    assign(conn, :current_user, user)
  end
end
