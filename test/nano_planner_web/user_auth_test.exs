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
      assert token = get_session(conn, :user_token)
      assert redirected_to(conn) == "/"
      assert Accounts.get_user_by_session_token(token)
    end
  end
end
