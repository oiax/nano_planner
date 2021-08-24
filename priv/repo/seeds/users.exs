import NanoPlanner.Repo
alias NanoPlanner.Accounts.User

for login_name <- ~w(alice bob carol david eve) do
  hashed_password = Bcrypt.hash_pwd_salt(login_name <> "123!")

  insert!(%User{
    login_name: login_name,
    hashed_password: hashed_password
  })
end
