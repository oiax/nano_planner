alias NanoPlanner.Schedule.PlanItem
alias NanoPlanner.Repo

item = PlanItem |> Ecto.Query.first(:id) |> Repo.one()
params = %{
  "name" => "Foo",
  "description" => "Bar"
}
fields = [:name, :description]
cs = Ecto.Changeset.cast(item, params, fields)

Repo.update!(cs)
