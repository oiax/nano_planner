defmodule NanoPlannerWeb.CounterPlug do
  @behaviour Plug

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, _opts) do
    if conn.method == "GET" do
      Counter.Agent.increment()
    end

    conn
  end
end
