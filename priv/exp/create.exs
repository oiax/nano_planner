import NanoPlanner.Repo
alias NanoPlanner.Calendar.PlanItem

item = %PlanItem{}
params = %{
  "name" => "Test",
  "description" => "Experiment",
  "starts_at" => "2018-04-01T12:00:00",
  "ends_at" => "2018-04-01T13:00:00"
}
fields = [:name, :description, :starts_at, :ends_at]
cs = Ecto.Changeset.cast(item, params, fields)

insert! cs

IO.puts aggregate(PlanItem, :count, :id)
