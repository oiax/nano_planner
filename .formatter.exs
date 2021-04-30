[
  import_deps: [:ecto, :phoenix],
  inputs: [
    "*.{ex,exs}",
    "priv/repo/seeds.exs",
    "priv/v0?/**/*.{ex,exs}",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  subdirectories: ["priv/*/migrations"],
  line_length: 80
]
