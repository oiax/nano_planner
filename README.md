# NanoPlanner: 簡易予定表管理システム

これは『Elixir/Phoenix 入門③』の学習用 Phoenix アプリケーションです。

## 対象 OS

* macOS High Sierra v10.13
* macOS Sierra v10.12
* OS X v10.11 El Capitan
* OS X v10.10 Yosemite
* Ubuntu Desktop 16.04 LTS (64-bit)

## 稼働条件

* Erlang 21.0
* Elixir 1.6.6
* Phoenix 1.3.3
* PostgreSQL 9.5/9.6
* Node.js 8.11.3
* npm 6.1.0

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
$ mix ecto.migrate
$ mix run priv/repo/seeds.exs
$ cd assets
$ npm install
$ cd ..
```

## 準備作業

`192.168.56.101` と `192.168.56.102` で動くふたつのホストを用意する。

それぞれの `/etc/hosts` に次のような記載を加えておく。

```text
192.168.56.101  host1.local
192.168.56.102  host2.local
```

ホスト名には `oiax` のようなドットを含まないものではなく、FQDN のように見えるものを指定する。

## 起動方法

`192.168.56.101` において。

```console
$ MASTER=1 elixir --name np@192.168.56.101 -S mix phx.server
```

`192.168.56.102` において。

```console
$ elixir --name np@192.168.56.102 -S mix phx.server
```

### 注意点

* `--sname` オプションではなく `--name` オプションを使う。
* `--name` の後に `=` を付けない。
* 両ホストともにファイアウォールが無効であることを確認。
* 両ホストの `~/.erlang.cookie` の中身が同一であることを確認。
* `epmd` をあらかじめ起動しておく必要はない。自動で起動する。
