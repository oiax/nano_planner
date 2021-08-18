defmodule NanoPlannerWeb.SessionController do
  use NanoPlannerWeb, :controller

  def show(conn, _params) do
    message = get_session(conn, "message")
    render(conn, "show.html", message: message)
  end

  def set(conn, %{"message" => message} = _params) do
    conn
    |> put_session("message", message)
    |> redirect(to: "/session")
  end

  def unset(conn, _params) do
    conn
    |> delete_session("message")
    |> redirect(to: "/session")
  end
end
