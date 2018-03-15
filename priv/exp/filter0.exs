import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

names = ~W(読書 買い物)

items =
  PlanItem
  |> where([i], i.name in ^names)
  |> order_by(asc: :id)
  |> Repo.all()
  |> Enum.map(&(&1.name))

IO.inspect(items)
