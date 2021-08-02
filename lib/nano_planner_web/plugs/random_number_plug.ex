defmodule NanoPlannerWeb.RandomNumberPlug do
  import Plug.Conn

  @behaviour Plug

  @impl Plug
  def init(opts) do
    Keyword.merge([min: 1, max: 100], opts)
  end

  @impl Plug
  def call(conn, opts) do
    min = opts[:min]
    max = opts[:max]
    assign(conn, :number, Enum.random(min..max))
  end
end
