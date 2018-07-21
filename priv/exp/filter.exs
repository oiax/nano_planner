import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

pattern = "%買う%"

items =
  PlanItem
  |> where([i], not like(i.description, ^pattern))
  |> or_where([i], i.name == "帰省")
  |> or_where([i], i.name == "買い物")
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(& &1.name)

IO.inspect(items)
