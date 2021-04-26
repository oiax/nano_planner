u = %User{name: "foo", email: "foo@example.com"}
%User{name: "foo", email: x} = u
IO.inspect(x)
