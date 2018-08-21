IO.inspect(is_atom(nil))

opts = [foo: 0]

u = Keyword.has_key?(opts, :foo)
v = Keyword.has_key?(opts, nil)

IO.inspect(u)
IO.inspect(v)
