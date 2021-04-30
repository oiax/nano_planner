import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

article = "猫の餌"

items =
  PlanItem
  |> where(description: ^(article <> "を買う"))
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(& &1.description)

IO.inspect(items)
