defmodule Mix.Tasks.Db.Count do
  use Mix.Task

  @shortdoc "Show the record count of a database table"

  def run(args) do
    repo = Mix.Util.get_repo
    mod = List.first(args) |> Mix.Util.model_module

    IO.puts repo.aggregate(mod, :count, :id)
  end
end
