defmodule NanoPlannerWeb.UserSessionControllerTest do
  use NanoPlannerWeb.ConnCase, async: true
  import NanoPlanner.AccountsFixtures

  describe "GET /users/log_in" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "ログインフォームを表示する", %{conn: conn} do
      conn = get(conn, Routes.user_session_path(conn, :new))

      assert Phoenix.Controller.view_template(conn) == "new.html"
    end

    test "トップページにリダイレクトする", %{conn: conn, user: user} do
      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.user_session_path(conn, :new))

      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /users/log_in" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "ログインに成功する", %{conn: conn, user: user} do
      params = %{
        "user" => %{
          "login_name" => user.login_name,
          "password" => user.login_name <> "123!"
        }
      }

      conn = post(conn, Routes.user_session_path(conn, :create), params)

      assert redirected_to(conn) == "/"
    end

    test "ログインに失敗する", %{conn: conn, user: user} do
      params = %{
        "user" => %{
          "login_name" => user.login_name,
          "password" => "oops!"
        }
      }

      conn = post(conn, Routes.user_session_path(conn, :create), params)

      assert Phoenix.Controller.view_template(conn) == "new.html"
    end

    test "トップページにリダイレクトする", %{conn: conn, user: user} do
      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.user_session_path(conn, :new))

      assert redirected_to(conn) == "/"
    end
  end
end
