list = [100, [1, 2, 3], %{value: 7}, true]

for e <- list do
  x =
    case e do
      n when is_integer(n) -> n
      l when is_list(l) -> Enum.join(l, ":")
      m when is_map(m) -> "value = #{m.value}"
      b when is_boolean(b) -> b
    end

  IO.puts(x)
end
