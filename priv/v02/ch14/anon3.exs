double = fn
  n when is_integer(n) -> n * 2
  x when is_float(x) -> x * 2
  s when is_binary(s) -> s <> s
end

x = double.(7)
y = double.(2.5)
z = double.("abc")
IO.inspect([x, y, z])
