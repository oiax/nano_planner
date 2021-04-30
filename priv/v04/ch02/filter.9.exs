import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

names = pattern = "%買う%"

items =
  PlanItem
  |> where([i], like(i.description, ^pattern))
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(& &1.description)

IO.inspect(items)
