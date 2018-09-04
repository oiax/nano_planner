import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

name = "読書"
time0 = Timex.now("Asia/Tokyo") |> Timex.beginning_of_day()
time1 = time0 |> Timex.shift(days: 1)
time2 = time0 |> Timex.shift(days: 7)

items =
  PlanItem
  |> where(
    [i],
    i.name != ^name or (i.starts_at > ^time1 and i.starts_at < ^time2)
  )
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(& &1.name)

IO.inspect(items)
