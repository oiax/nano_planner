double = fn {atom, n} -> {atom, n * 2} end
x = double.({:a, 7})
IO.inspect(x)
