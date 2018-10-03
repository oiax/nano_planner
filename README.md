# NanoPlanner: 簡易予定表管理システム

これは『Elixir/Phoenix初級②〜④』の学習用 Phoenix アプリケーションです。

## 対象 OS

* macOS High Sierra v10.13
* macOS Sierra v10.12
* OS X v10.11 El Capitan
* OS X v10.10 Yosemite
* Ubuntu Desktop 16.04 LTS (64-bit)

## 稼働条件

* Erlang 21.0
* Elixir 1.7.3
* Phoenix 1.4.0-dev
* PostgreSQL 9.5/9.6/10
* Node.js 8.12.0
* npm 6.4.0
* webpack 4.17.1

Ubuntu 16.04 では、さらに次のコマンドで `inotify-tools` パッケージをインストールしてください。

```text
$ sudo apt-get -y install inotify-tools
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

## インストール方法

```text
$ mix local.hex --force
$ mix local.rebar --force
$ mix deps.get
$ mix ecto.create
$ mix ecto.migrate
$ mix run priv/repo/seeds.exs
$ cd assets
$ npm install
$ cd ..
```

## 起動方法

```text
$ mix phx.server
```

## Copyright and License

Copyright (c) 2018, Tsutomu Kuroda.

NanoPlanner source code is licensed under the [MIT License](LICENSE.md).
