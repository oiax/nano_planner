defmodule NanoPlannerWeb.CounterPlug do
  @behaviour Plug

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(%{:method => "GET"} = conn, _opts) do
    Counter.Agent.increment()

    conn
  end

  def call(conn, _opts) do
    conn
  end
end
