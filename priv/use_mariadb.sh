sed -i -e 's/:postgrex/:myxql/' mix.exs
sed -i -e 's/Postgres/MyXQL/' lib/nano_planner/repo.ex
sed -i -e 's/username: "postgres"/username: "root"/' config/dev.exs
sed -i -e 's/password: "postgres"/password: "root"/' config/dev.exs
sed -i -e 's/hostname: "postgres"/hostname: "mariadb"/' config/dev.exs
mix deps.get
