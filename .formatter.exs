[
  import_deps: [:ecto, :phoenix],
  inputs: [
    "*.{ex,exs}",
    "priv/repo/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "priv/v0?/**/*.{ex,exs}"
  ],
  subdirectories: ["priv/*/migrations"],
  line_length: 80
]
