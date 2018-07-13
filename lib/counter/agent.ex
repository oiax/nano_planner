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
    Agent.get(__MODULE__, fn state -> state end)
  end

  @doc """
  Increment the current value by one.
  """
  def increment() do
    value = Agent.get_and_update(__MODULE__, fn state -> {state, state + 1} end)
    value + 1
  end
end
