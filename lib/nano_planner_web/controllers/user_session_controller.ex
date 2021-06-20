defmodule NanoPlannerWeb.UserSessionController do
  use NanoPlannerWeb, :controller

  alias NanoPlanner.Accounts
  alias NanoPlannerWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"login_name" => login_name, "password" => password} = user_params

    if user = Accounts.get_user_by_login_name_and_password(login_name, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the login_name is registered.
      render(conn, "new.html", error_message: "Invalid login_name or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
