defmodule StringBuffer do
  def start_link do
    Agent.start_link fn -> [] end
  end

  def append(pid, string) do
    Agent.update(pid, fn(list) -> [string | list] end)
  end

  def get(pid) do
    Agent.get(pid, fn(list) -> list |> Enum.reverse |> Enum.join end)
  end

  def stop(pid) do
    Agent.stop(pid)
  end
end
