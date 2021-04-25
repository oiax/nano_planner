import NanoPlanner.Repo, only: [insert!: 1]
alias NanoPlanner.Schedule.PlanItem

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
  ends_at: Timex.shift(time0, days: 1, hours: 11)
})

insert!(%PlanItem{
  name: "買い物",
  description: "洗剤を買う",
  starts_at: Timex.shift(time0, hours: 16),
  ends_at: Timex.shift(time0, hours: 16, minutes: 30)
})

insert!(%PlanItem{
  name: "帰省",
  description: "新幹線の指定席を取る。\nお土産を買う。",
  starts_at: Timex.shift(time1, years: 1, days: -2),
  ends_at: Timex.shift(time1, years: 1, days: 3)
})
