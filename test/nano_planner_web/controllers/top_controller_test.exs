defmodule NanoPlannerWeb.TopControllerTest do
  use NanoPlannerWeb.ConnCase, async: true
  alias NanoPlanner.Accounts
  import NanoPlanner.AccountsFixtures

  describe "GET /" do
    setup do
      user = user_fixture(login_name: "alice")
      {:ok, user: user}
    end

    test "ウェルカムページを表示する", %{conn: conn} do
      conn = get(conn, "/")

      assert Phoenix.Controller.view_template(conn) == "welcome.html"
    end

    test "ログイン後のトップページを表示する", %{conn: conn, user: user} do
      session_token = Accounts.generate_session_token(user)

      conn =
        conn
        |> init_test_session(%{})
        |> put_session(:session_token, session_token)
        |> get("/")

      assert Phoenix.Controller.view_template(conn) == "index.html"
    end
  end
end
