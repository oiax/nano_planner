import NanoPlanner.Repo
alias NanoPlanner.Schedule.PlanItem

time0 = DateTime.from_unix!(0)

item =
  insert!(%PlanItem{
    name: "TEST",
    description: "TEST",
    starts_at: time0,
    ends_at: time0
  })

IO.inspect(item.inserted_at, structs: false)
