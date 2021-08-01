sed -i -e 's/:postgrex/:myxql/' mix.exs
sed -i -e 's/Postgres/MyXQL/' lib/nano_planner/repo.ex
sed -i -e 's/username: "postgres"/username: "root"/' config/dev.exs
sed -i -e 's/password: "postgres"/password: "root"/' config/dev.exs
sed -i -e 's/hostname: "postgres"/hostname: "mariadb"/' config/dev.exs
sed -i -e 's/username: "postgres"/username: "root"/' config/test.exs
sed -i -e 's/password: "postgres"/password: "root"/' config/test.exs
sed -i -e 's/hostname: "postgres"/hostname: "mariadb"/' config/test.exs
mix deps.clean --all
mix deps.get
