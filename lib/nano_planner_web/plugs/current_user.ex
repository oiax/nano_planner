defmodule NanoPlannerWeb.CurrentUser do
  import Plug.Conn
  alias NanoPlanner.Accounts

  @behaviour Plug

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    session_token = get_session(conn, :session_token)

    if session_token do
      user = Accounts.get_user_by_session_token(session_token)
      assign(conn, :current_user, user)
    else
      conn
    end
  end
end
