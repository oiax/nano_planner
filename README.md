# NanoPlanner: 簡易予定表管理システム

これは『Elixir/Phoenix 入門②』の学習用 Phoenix アプリケーションです。

## 対象 OS

* OS X v10.11
* macOS Sierra v10.12
* Ubuntu 16.04

## 稼働条件

* Erlang 19.1
* Elixir 1.3.4
* Phoenix 1.2.1
* PostgreSQL 9.4
* Node.js 6.9.1
* npm 3.10.8

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
