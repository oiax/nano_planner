atom = :a
t = {:b, 3}

x =
  case t do
    {atom, n} -> n
    _ -> 0
  end

IO.puts(x)
