Logger.configure(level: :warn)

filenames = ~w(
  users
  plan_items
)

Enum.map(filenames, fn filename ->
  IO.puts(filename)
  Code.eval_file("./priv/repo/seeds/#{filename}.exs")
end)
