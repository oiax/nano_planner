defmodule NanoPlannerWeb.PlugController do
  use NanoPlannerWeb, :controller

  plug NanoPlannerWeb.RandomNumberPlug, min: 101, max: 200

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
