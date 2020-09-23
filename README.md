# NanoPlanner: 簡易予定表管理システム

これは『Elixir/Phoenix初級②』の学習用 Phoenix アプリケーションです。

## 対象 OS

* macOS Big Sur v11
* macOS Catalina v10.15
* Ubuntu Desktop 20.04 LTS (64-bit)

## 稼働条件

* Erlang/OTP 23.2.1
* Elixir 1.11.3
* Phoenix 1.5.7
* PostgreSQL 12.5
* Node.js 14.15.4
* npm 7.5.4
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

Copyright (c) 2021, Tsutomu Kuroda.

NanoPlanner source code is licensed under the [MIT License](LICENSE.md).

