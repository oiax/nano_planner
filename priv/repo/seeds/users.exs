import NanoPlanner.Accounts, only: [register_user: 1]

for name <- ~w(alice bob carol david eve) do
  {:ok, _user} = register_user(%{login_name: name, password: "NanoPlanner!"})
end
