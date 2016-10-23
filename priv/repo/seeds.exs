import NanoPlanner.Repo, only: [insert!: 1]
alias NanoPlanner.PlanItem

insert! %PlanItem{
  name: "読書",
  description: "『走れメロス』を読む"
}
