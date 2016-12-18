defmodule Mix.Util do
  import Mix.Ecto

  def get_repo do
    [repo|_] = parse_repo([])
    ensure_started(repo, [])
    repo
  end

  def model_module(name) do
    app_name = Mix.Project.config[:app] |> Atom.to_string() |> Macro.camelize()
    model_name = Macro.camelize(name)
    Module.concat(app_name, model_name)
  end
end
