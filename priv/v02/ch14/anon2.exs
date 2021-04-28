double_or_triple = fn
  {:a, n} -> {:a, n * 2}
  {:b, n} -> {:b, n * 3}
end

x = double_or_triple.({:a, 7})
y = double_or_triple.({:b, 5})
IO.inspect(x)
IO.inspect(y)
