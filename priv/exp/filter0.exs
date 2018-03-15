import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

name = "読書"

items =
  PlanItem
  |> where(name: ^name)
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(&(&1.name))

IO.inspect(items)
