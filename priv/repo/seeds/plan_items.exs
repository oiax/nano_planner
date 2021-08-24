import NanoPlanner.Repo
alias NanoPlanner.Accounts.User
alias NanoPlanner.Schedule.PlanItem

alice = get_by!(User, login_name: "alice")
bob = get_by!(User, login_name: "bob")

now =
  "Asia/Tokyo"
  |> DateTime.now!()
  |> DateTime.truncate(:second)

time0 =
  now
  |> Timex.beginning_of_day()
  |> DateTime.shift_zone!("Etc/UTC")

time1 =
  now
  |> Timex.beginning_of_year()
  |> DateTime.shift_zone!("Etc/UTC")

insert!(%PlanItem{
  name: "読書",
  description: "『走れメロス』を読む",
  starts_at: Timex.shift(time0, days: 1, hours: 10),
  ends_at: Timex.shift(time0, days: 1, hours: 11),
  owner: alice
})

insert!(%PlanItem{
  name: "買い物",
  description: "洗剤を買う",
  starts_at: Timex.shift(time0, hours: 16),
  ends_at: Timex.shift(time0, hours: 16, minutes: 30),
  owner: alice
})

insert!(%PlanItem{
  name: "帰省",
  description: "新幹線の指定席を取る。\nお土産を買う。",
  starts_at: Timex.shift(time1, years: 1, days: -2),
  ends_at: Timex.shift(time1, years: 1, days: 3),
  owner: alice
})

insert!(%PlanItem{
  name: "買い物",
  description: "猫の餌を買う",
  starts_at: Timex.shift(time0, days: 3, hours: 11),
  ends_at: Timex.shift(time0, days: 3, hours: 11, minutes: 30),
  owner: alice
})

insert!(%PlanItem{
  name: "歯医者",
  description: "",
  starts_at: Timex.shift(time0, days: 10, hours: 15),
  ends_at: Timex.shift(time0, days: 10, hours: 16),
  owner: alice
})

insert!(%PlanItem{
  name: "DVD鑑賞",
  description: "作品未定",
  starts_at: Timex.shift(time0, hours: 23),
  ends_at: Timex.shift(time0, hours: 25),
  owner: alice
})

insert!(%PlanItem{
  name: "姉の出張",
  description: "札幌",
  starts_at: Timex.shift(time0, days: -1, hours: 10),
  ends_at: Timex.shift(time0, days: 1, hours: 17),
  owner: alice
})

date0 = DateTime.to_date(time0)

%PlanItem{
  name: "私の誕生日",
  description: "",
  all_day: true,
  starts_on: Date.add(date0, 7),
  ends_on: Date.add(date0, 7),
  owner: alice
}
|> NanoPlanner.Schedule.set_time_boundaries()
|> insert!()

%PlanItem{
  name: "社員研修",
  description: "都内某所",
  all_day: true,
  starts_on: Date.add(date0, 14),
  ends_on: Date.add(date0, 16),
  owner: bob
}
|> NanoPlanner.Schedule.set_time_boundaries()
|> insert!()
