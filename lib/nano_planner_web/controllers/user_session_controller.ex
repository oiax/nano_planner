defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

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
      render(conn, "new.html")
    end
  end
end
