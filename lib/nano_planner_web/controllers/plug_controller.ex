defmodule NanoPlannerWeb.PlugController do
  use NanoPlannerWeb, :controller

  plug :set_number

  def show(conn, _params) do
    render(conn, "show.html")
  end

  defp set_number(conn, _opts) do
    assign(conn, :number, Enum.random(1..100))
  end
end
