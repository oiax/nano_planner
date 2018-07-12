defmodule Counter.Agent do
  use Agent

  @doc """
  Starts a new counter.
  """
  def start_link() do
    Agent.start_link(fn -> 0 end)
  end

  @doc """
  Gets the current value.
  """
  def get_value(agent) do
    Agent.get(agent, fn value -> value end)
  end

  @doc """
  Increment the current value by one.
  """
  def increment(agent) do
    Agent.update(agent, fn value -> value + 1 end)
  end
end
