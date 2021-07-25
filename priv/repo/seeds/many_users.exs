import NanoPlanner.Repo, only: [insert!: 1]
alias NanoPlanner.Accounts.User
alias NanoPlanner.Schedule.PlanItem

now =
  "Asia/Tokyo"
  |> DateTime.now!()
  |> DateTime.truncate(:second)

time0 =
  now
  |> Timex.beginning_of_day()
  |> DateTime.shift_zone!("Etc/UTC")
  |> Timex.shift(days: 1, hours: 10)

time1 =
  now
  |> Timex.beginning_of_day()
  |> DateTime.shift_zone!("Etc/UTC")
  |> Timex.shift(days: 1, hours: 11)

for n <- 1..2000 do
  login_name = "test-#{n}"
  hashed_password = Bcrypt.hash_pwd_salt(login_name <> "-888")

  user =
    insert!(%User{
      login_name: login_name,
      hashed_password: hashed_password
    })

  insert!(%PlanItem{
    name: "Test",
    description: "",
    starts_at: time0,
    ends_at: time1,
    owner: user
  })
end
