list = [1, 2, 3]

list =
  list
  |> Enum.map(&(&1 * 2))
  |> Enum.map(&(&1 * &1))

IO.inspect(list)
