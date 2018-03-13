# NanoPlanner: 簡易予定表管理システム

これは『Elixir/Phoenix 入門④』の学習用 Phoenix アプリケーションです。

## 対象 OS

* macOS High Sierra v10.13
* macOS Sierra v10.12
* OS X v10.11 El Capitan
* OS X v10.10 Yosemite
* Ubuntu Desktop 16.04 LTS (64-bit)

## 稼働条件

* Erlang 20.2
* Elixir 1.6.3
* Phoenix 1.3.2
* PostgreSQL 9.5/9.6
* Node.js 8.10.0
* npm 5.7.1

Ubuntu 16.04 では、さらに次のコマンドで `inotify-tools` パッケージをインストールしてください。

```text
$ sudo apt-get -y install inotify-tools
```

## インストール方法

```text
$ mix local.hex --force
$ mix local.rebar --force
$ mix deps.get
$ mix ecto.create
$ mix ecto.load
$ mix run priv/repo/seeds.exs
```

## 起動方法

```text
$ mix phoenix.server
```
