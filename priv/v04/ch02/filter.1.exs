import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

items =
  PlanItem
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(& &1.name)

IO.inspect(items)
