defmodule NanoPlannerWeb.PlugController do
  use NanoPlannerWeb, :controller

  plug :set_number, min: 101, max: 200

  def show(conn, _params) do
    render(conn, "show.html")
  end

  defp set_number(conn, opts) do
    min = opts[:min] || 1
    max = opts[:max] || 100
    assign(conn, :number, Enum.random(min..max))
  end
end
