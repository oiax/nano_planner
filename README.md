# NanoPlanner: 簡易予定表管理システム

これは『Elixir/Phoenix初級②』の学習用 Phoenix アプリケーションです。

## 対象 OS

* macOS Catalina v10.15
* macOS Mojave v10.14
* macOS High Sierra v10.13
* Ubuntu Desktop 20.04 LTS (64-bit)

## 稼働条件

* Erlang 22.3.4.10
* Elixir 1.10.4
* Phoenix 1.5.5
* PostgreSQL 12.4
* Node.js 12.18.4
* npm 6.14.6
* webpack 4.41.5

Ubuntu 20.04 では、さらに次のコマンドで `inotify-tools` パッケージをインストールし、 `max_user_watches` の上限を変更してください。

```text
$ sudo apt-get -y install inotify-tools
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

## インストール方法

```text
$ mix local.hex --force
$ mix local.rebar --force
$ mix deps.get
$ mix ecto.setup
$ cd assets
$ npm install
$ cd ..
```

## 起動方法

```text
$ mix phx.server
```

## Copyright and License

Copyright (c) 2020, Tsutomu Kuroda.

NanoPlanner source code is licensed under the [MIT License](LICENSE.md).

