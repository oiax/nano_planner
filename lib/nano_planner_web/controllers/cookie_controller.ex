defmodule NanoPlannerWeb.CookieController do
  use NanoPlannerWeb, :controller

  def show(conn, _params) do
    message = conn.cookies["message"]
    render(conn, "show.html", message: message)
  end

  def set(conn, %{"message" => message} = _params) do
    conn
    |> put_resp_cookie("message", message)
    |> redirect(to: "/cookie")
  end

  def unset(conn, _params) do
    conn
    |> delete_resp_cookie("message")
    |> redirect(to: "/cookie")
  end
end
