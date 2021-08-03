defmodule NanoPlannerWeb.TopControllerTest do
  use NanoPlannerWeb.ConnCase

  describe "GET /" do
    test "ウェルカムページを表示する", %{conn: conn} do
      conn = get(conn, "/")

      assert Phoenix.Controller.view_template(conn) == "welcome.html"
    end

    @tag :login
    test "ログイン後のトップページを表示する", %{conn: conn} do
      conn = get(conn, "/")

      assert Phoenix.Controller.view_template(conn) == "index.html"
    end
  end
end
