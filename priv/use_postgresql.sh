sed -i -e 's/:myxql/:postgrex/' mix.exs
sed -i -e 's/MyXQL/Postgres/' lib/nano_planner/repo.ex
sed -i -e 's/username: "root"/username: "postgres"/' config/dev.exs
sed -i -e 's/password: "root"/password: "postgres"/' config/dev.exs
sed -i -e 's/hostname: "mariadb"/hostname: "postgres"/' config/dev.exs
mix deps.get
