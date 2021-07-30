defmodule NanoPlannerWeb.TopControllerTest do
  use NanoPlannerWeb.ConnCase, async: true

  describe "GET /" do
    test "ウェルカムページを表示する", %{conn: conn} do
      conn = get(conn, Routes.top_path(conn, :index))

      assert Phoenix.Controller.view_template(conn) == "welcome.html"
    end

    @tag :login
    test "ログイン後のトップページを表示する", %{conn: conn} do
      conn = get(conn, Routes.top_path(conn, :index))

      assert Phoenix.Controller.view_template(conn) == "index.html"
    end
  end
end
