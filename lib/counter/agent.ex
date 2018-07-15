defmodule Counter.Agent do
  use Agent

  @agent_name {:via, Registry, {Registry.Global, "agent"}}

  @doc """
  Starts a new counter.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> 0 end, name: @agent_name)
  end

  @doc """
  Gets the current value.
  """
  def get_value() do
    Agent.get(@agent_name, & &1)
  end

  @doc """
  Increment the current value by one.
  """
  def increment() do
    Agent.update(@agent_name, &(&1 + 1))
  end
end
