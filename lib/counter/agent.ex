defmodule Counter.Agent do
  use Agent

  @doc """
  Starts a new counter.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  @doc """
  Gets the current value.
  """
  def get_value() do
    Agent.get(__MODULE__, &(&1))
  end

  @doc """
  Increment the current value by one.
  """
  def increment() do
    Agent.update(__MODULE__, &(&1 + 1))
  end
end
