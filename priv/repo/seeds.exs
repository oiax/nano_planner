Logger.configure(level: :warning)

filenames = ~w(
  users
  plan_items
)

for filename <- filenames do
  IO.puts(filename)
  path = Path.join([__DIR__, "seeds", filename <> ".exs"])
  Code.eval_file(path)
end
