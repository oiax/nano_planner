u = %User{name: "foo", email: "foo@example.com"} 
u = Map.merge(u, %{name: "bar"})
IO.inspect(u)
