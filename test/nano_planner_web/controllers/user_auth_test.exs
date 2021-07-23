defmodule NanoPlannerWeb.UserAuthTest do
  use NanoPlannerWeb.ConnCase, async: true

  alias NanoPlanner.Accounts
  alias NanoPlannerWeb.UserAuth
  import NanoPlanner.AccountsFixtures

  setup %{conn: conn} do
    conn =
      conn
      |> Map.replace!(
        :secret_key_base,
        NanoPlannerWeb.Endpoint.config(:secret_key_base)
      )
      |> init_test_session(%{})

    %{user: user_fixture(), conn: conn}
  end

  describe "log_in_user/3" do
    test "セッションにユーザートークンを保存する", %{conn: conn, user: user} do
      conn = UserAuth.log_in_user(conn, user)
      assert session_token = get_session(conn, :session_token)
      assert redirected_to(conn) == "/"

      assert %Accounts.User{} =
               Accounts.get_user_by_session_token(session_token)
    end
  end

  describe "logout_user/1" do
    test "セッションを消去する", %{conn: conn, user: user} do
      session_token = Accounts.generate_session_token(user)

      conn =
        conn
        |> put_session(:session_token, session_token)
        |> fetch_cookies()
        |> UserAuth.log_out_user()

      assert get_session(conn, :session_token) == nil
      assert redirected_to(conn) == "/"
      assert Accounts.get_user_by_session_token(session_token) == nil
    end
  end
end
