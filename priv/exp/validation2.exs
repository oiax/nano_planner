alias NanoPlanner.Schedule.PlanItem

item = %PlanItem{}
attrs = %{"name" => "TEST"}
cs = PlanItem.changeset(item, attrs)

IO.inspect(cs.valid?)
IO.inspect(cs.errors)
