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
      assert user_token = get_session(conn, :user_token)
      assert redirected_to(conn) == "/"
      assert %Accounts.User{} = Accounts.get_user_by_session_token(user_token)
    end
  end

  describe "logout_user/1" do
    test "セッションを消去する", %{conn: conn, user: user} do
      user_token = Accounts.generate_user_session_token(user)

      conn =
        conn
        |> put_session(:user_token, user_token)
        |> fetch_cookies()
        |> UserAuth.log_out_user()

      assert get_session(conn, :user_token) == nil
      assert redirected_to(conn) == "/"
      assert Accounts.get_user_by_session_token(user_token) == nil
    end
  end
end
