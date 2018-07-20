import NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

time0 = Timex.now("Asia/Tokyo") |> Timex.beginning_of_day
time1 = time0 |> Timex.beginning_of_year

insert! %PlanItem{
  name: "読書",
  description: "『走れメロス』を読む",
  starts_at: Timex.shift(time0, days: 1, hours: 10),
  ends_at: Timex.shift(time0, days: 1, hours: 11)
}

insert! %PlanItem{
  name: "買い物",
  description: "洗剤を買う",
  starts_at: Timex.shift(time0, hours: 16),
  ends_at: Timex.shift(time0, hours: 16, minutes: 30)
}

insert! %PlanItem{
  name: "帰省",
  description: "新幹線の指定席を取る。\nお土産を買う。",
  starts_at: Timex.shift(time1, years: 1, days: -2),
  ends_at: Timex.shift(time1, years: 1, days: 3)
}

insert! %PlanItem{
  name: "DVD鑑賞",
  description: "作品未定",
  starts_at: Timex.shift(time0, hours: 23),
  ends_at: Timex.shift(time0, hours: 25)
}

insert! %PlanItem{
  name: "姉の出張",
  description: "札幌",
  starts_at: Timex.shift(time0, days: -1, hours: 10),
  ends_at: Timex.shift(time0, hours: 17)
}
