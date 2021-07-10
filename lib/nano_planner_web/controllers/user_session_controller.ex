defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller
  alias NanoPlannerWeb.UserAuth
  alias NanoPlanner.Accounts

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
      UserAuth.log_in_user(conn, user, user_params)
    else
      render(conn, "new.html")
    end
  end
end
