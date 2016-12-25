defmodule StringBuffer do
  def start_link do
    pid = spawn_link fn -> listen([]) end
    {:ok, pid}
  end

  def append(pid, string) do
    send pid, {:append, string}
  end

  def get(pid) do
    send pid, {:get, self}

    receive do
      list -> list
    end
  end

  def listen(list) do
    receive do
      {:append, string} -> listen([string | list])
      {:get, from} ->
        send from, list |> Enum.reverse |> Enum.join
        listen(list)
    end
  end
end
