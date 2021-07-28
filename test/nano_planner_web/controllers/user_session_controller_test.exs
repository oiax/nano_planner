defmodule NanoPlannerWeb.UserSessionControllerTest do
  use NanoPlannerWeb.ConnCase, async: true

  describe "GET /users/log_in" do
    test "ログインフォームを表示する", %{conn: conn} do
      conn = get(conn, Routes.user_session_path(conn, :new))
      assert conn.status == 200
    end
  end
end
