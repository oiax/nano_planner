defmodule NanoPlannerWeb.RandomNumber do
  import Plug.Conn

  def set_number(conn, opts) do
    min = opts[:min] || 1
    max = opts[:max] || 100
    assign(conn, :number, Enum.random(min..max))
  end
end
