defmodule NanoPlannerWeb.CounterPlug do
  @behaviour Plug

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, _opts) do
    Counter.Agent.increment()
    conn
  end
end
