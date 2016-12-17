defmodule Mix.Tasks.Db.Count do
  use Mix.Task
  import Mix.Ecto

  @shortdoc "Show the record count of a database table"

  def run(args) do
    [repo|_] = parse_repo([])
    ensure_repo(repo, args)
    ensure_started(repo, [])

    app_name = Mix.Project.config[:app] |> Atom.to_string() |> Macro.camelize()
    model_name = List.first(args) |> Macro.camelize()

    IO.puts repo.aggregate(Module.concat(app_name, model_name), :count, :id)
  end
end
