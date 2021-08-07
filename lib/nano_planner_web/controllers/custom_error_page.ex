defmodule NanoPlannerWeb.CustomErrorPage do
  import Plug.Conn, only: [put_status: 2, halt: 1]
  import Phoenix.Controller, only: [put_view: 2, render: 2]

  @reasons [:forbidden, :not_found]

  def show(conn, reason) when reason in @reasons do
    conn
    |> put_status(reason)
    |> put_view(NanoPlannerWeb.CustomErrorPageView)
    |> render("#{reason}.html")
    |> halt()
  end
end
