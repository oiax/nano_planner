import NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

time0 = Timex.now("Asia/Tokyo") |> Timex.beginning_of_day()
time1 = time0 |> Timex.beginning_of_year()

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

insert!(%PlanItem{
  name: "DVD鑑賞",
  description: "作品未定",
  starts_at: Timex.shift(time0, hours: 23),
  ends_at: Timex.shift(time0, hours: 25)
})

insert!(%PlanItem{
  name: "姉の出張",
  description: "札幌",
  starts_at: Timex.shift(time0, days: -1, hours: 10),
  ends_at: Timex.shift(time0, days: 1, hours: 17)
})

date0 = Timex.to_date(time0)

%PlanItem{
  name: "私の誕生日",
  description: "",
  all_day: true,
  starts_at: Timex.shift(time0, days: 7),
  ends_at: Timex.shift(time0, days: 8),
  starts_on: Date.add(date0, 7),
  ends_on: Date.add(date0, 7)
}
|> NanoPlanner.Schedule.set_time_boundaries()
|> insert!()

%PlanItem{
  name: "社員研修",
  description: "都内某所",
  all_day: true,
  starts_at: Timex.shift(time0, days: 14),
  ends_at: Timex.shift(time0, days: 17),
  starts_on: Date.add(date0, 14),
  ends_on: Date.add(date0, 16)
}
|> NanoPlanner.Schedule.set_time_boundaries()
|> insert!()
