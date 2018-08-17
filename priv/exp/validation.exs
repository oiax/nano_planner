import Ecto.Query
alias NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

item = PlanItem |> first |> Repo.one()
attrs = %{name: "TEST"}
cs = PlanItem.changeset(item, attrs)

IO.inspect(cs.valid?)
IO.inspect(cs.errors)
