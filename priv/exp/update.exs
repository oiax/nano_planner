import NanoPlanner.Repo
alias NanoPlanner.Calendar.PlanItem

item = PlanItem |> Ecto.Query.first(:id) |> one
params = %{
  "name" => "Foo",
  "description" => "Bar"
}
fields = [:name, :description]
cs = Ecto.Changeset.cast(item, params, fields)

update! cs
