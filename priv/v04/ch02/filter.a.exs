import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

pattern = "%買う%"
time0 = DateTime.now!("Asia/Tokyo") |> Timex.beginning_of_day()
time1 = time0 |> Timex.shift(days: 7)
time2 = time0 |> Timex.shift(days: 14)

items =
  PlanItem
  |> where(
    [i],
    like(i.description, ^pattern) or
      (i.starts_at > ^time1 and i.starts_at < ^time2)
  )
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(& &1.name)

IO.inspect(items)
