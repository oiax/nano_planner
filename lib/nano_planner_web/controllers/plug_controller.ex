defmodule NanoPlannerWeb.PlugController do
  use NanoPlannerWeb, :controller

  plug NanoPlannerWeb.RandomNumberPlug

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
