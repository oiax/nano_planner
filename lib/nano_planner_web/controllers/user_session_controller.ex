defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller
  alias NanoPlannerWeb.UserAuth
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
      UserAuth.log_in_user(conn, user, user_params)
    else
      render(conn, "new.html", error_message: @error_message)
    end
  end

  @logout_message "ログアウトしました。"

  def delete(conn, _params) do
    conn
    |> put_flash(:info, @logout_message)
    |> UserAuth.log_out_user()
  end
end
