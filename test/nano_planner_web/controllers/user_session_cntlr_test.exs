defmodule NanoPlannerWeb.UserSessionControllerTest do
  use NanoPlannerWeb.ConnCase, async: true
  import NanoPlanner.AccountsFixtures
  alias NanoPlanner.Accounts

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
      assert Map.has_key?(conn.assigns, :error_message)
      assert conn.assigns.error_message != nil
    end

    test "トップページにリダイレクトする", %{conn: conn, user: user} do
      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.user_session_path(conn, :new))

      assert redirected_to(conn) == "/"
    end
  end

  describe "DELETE /users/log_out" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "セッショントークンを削除する", %{conn: conn, user: user} do
      conn = log_in_user(conn, user)
      session_token = get_session(conn, :session_token)
      conn = delete(conn, Routes.user_session_path(conn, :delete))

      assert get_session(conn, :session_token) == nil
      assert get_flash(conn, :info) != nil
      assert redirected_to(conn) == "/"
      assert Accounts.get_user_by_session_token(session_token) == nil
    end
  end
end
