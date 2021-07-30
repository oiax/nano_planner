defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Accounts

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  @error_message "ログイン名またはパスワードが正しくありません。"

  def create(conn, %{"user" => user_params}) do
    user =
      Accounts.get_user_by_login_name_and_password(
        user_params["login_name"],
        user_params["password"]
      )

    if user do
      session_token = Accounts.generate_session_token(user)

      conn
      |> configure_session(renew: true)
      |> clear_session()
      |> put_session(:session_token, session_token)
      |> redirect(to: Routes.top_path(conn, :index))
    else
      render(conn, "new.html", error_message: @error_message)
    end
  end

  def delete(conn, _params) do
    session_token = get_session(conn, :session_token)
    session_token && Accounts.delete_session_token(session_token)

    conn
    |> configure_session(renew: true)
    |> clear_session()
    |> redirect(to: Routes.top_path(conn, :index))
  end
end
