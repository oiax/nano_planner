Logger.configure(level: :warn)

filenames = ~w(
  users
  plan_items
)

Enum.map(filenames, fn filename ->
  IO.puts(filename)
  path = Path.join([__DIR__, "seeds", filename <> ".exs"])
  Code.eval_file(path)
end)
