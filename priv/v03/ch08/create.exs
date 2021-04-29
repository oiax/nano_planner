alias NanoPlanner.Schedule.PlanItem
alias NanoPlanner.Repo

item = %PlanItem{}

params = %{
  "name" => "Test",
  "description" => "Experiment",
  "starts_at" => "2021-04-29T12:00:00+09:00",
  "ends_at" => "2021-04-29T13:00:00+09:00"
}

fields = [:name, :description, :starts_at, :ends_at]
cs = Ecto.Changeset.cast(item, params, fields)

Repo.insert!(cs)
