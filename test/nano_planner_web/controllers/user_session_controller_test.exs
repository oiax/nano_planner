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
      assert conn.status == 200
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
