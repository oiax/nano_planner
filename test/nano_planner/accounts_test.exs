defmodule NanoPlanner.AccountsTest do
  use NanoPlanner.DataCase

  alias NanoPlanner.Accounts

  import NanoPlanner.AccountsFixtures
  alias NanoPlanner.Accounts.{User, UserToken}

  describe "get_user_by_login_name/1" do
    test "does not return the user if the login_name does not exist" do
      refute Accounts.get_user_by_login_name("unknown@example.com")
    end

    test "returns the user if the login_name exists" do
      %{id: id} = user = user_fixture()
      assert %User{id: ^id} = Accounts.get_user_by_login_name(user.login_name)
    end
  end

  describe "get_user_by_login_name_and_password/2" do
    test "does not return the user if the login_name does not exist" do
      refute Accounts.get_user_by_login_name_and_password(
               "unknown@example.com",
               "hello world!"
             )
    end

    test "does not return the user if the password is not valid" do
      user = user_fixture()
      refute Accounts.get_user_by_login_name_and_password(user.login_name, "invalid")
    end

    test "returns the user if the login_name and password are valid" do
      %{id: id} = user = user_fixture()

      assert %User{id: ^id} =
               Accounts.get_user_by_login_name_and_password(
                 user.login_name,
                 valid_user_password()
               )
    end
  end

  describe "get_user!/1" do
    test "raises if id is invalid" do
      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_user!(-1)
      end
    end

    test "returns the user with the given id" do
      %{id: id} = user = user_fixture()
      assert %User{id: ^id} = Accounts.get_user!(user.id)
    end
  end

  describe "register_user/1" do
    test "requires login_name and password to be set" do
      {:error, changeset} = Accounts.register_user(%{})

      assert %{
               password: ["can't be blank"],
               login_name: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "validates login_name and password when given" do
      {:error, changeset} =
        Accounts.register_user(%{password: "not valid"})

      assert %{
               password: ["should be at least 12 character(s)"]
             } = errors_on(changeset)
    end

    test "validates maximum values for login_name and password for security" do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        Accounts.register_user(%{login_name: too_long, password: too_long})

      assert "should be at most 160 character(s)" in errors_on(changeset).login_name

      assert "should be at most 80 character(s)" in errors_on(changeset).password
    end

    test "validates login_name uniqueness" do
      %{login_name: login_name} = user_fixture()
      {:error, changeset} = Accounts.register_user(%{login_name: login_name})
      assert "has already been taken" in errors_on(changeset).login_name

      # Now try with the upper cased login_name too, to check that login_name case is ignored.
      {:error, changeset} =
        Accounts.register_user(%{login_name: String.upcase(login_name)})

      assert "has already been taken" in errors_on(changeset).login_name
    end

    test "registers users with a hashed password" do
      login_name = unique_user_login_name()
      {:ok, user} = Accounts.register_user(valid_user_attributes(login_name: login_name))
      assert user.login_name == login_name
      assert is_binary(user.hashed_password)
      assert is_nil(user.confirmed_at)
      assert is_nil(user.password)
    end
  end

  describe "change_user_registration/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} =
               changeset = Accounts.change_user_registration(%User{})

      assert changeset.required == [:password, :login_name]
    end

    test "allows fields to be set" do
      login_name = unique_user_login_name()
      password = valid_user_password()

      changeset =
        Accounts.change_user_registration(
          %User{},
          valid_user_attributes(login_name: login_name, password: password)
        )

      assert changeset.valid?
      assert get_change(changeset, :login_name) == login_name
      assert get_change(changeset, :password) == password
      assert is_nil(get_change(changeset, :hashed_password))
    end
  end

  describe "change_user_login_name/2" do
    test "returns a user changeset" do
      assert %Ecto.Changeset{} = changeset = Accounts.change_user_login_name(%User{})
      assert changeset.required == [:login_name]
    end
  end

  describe "apply_user_login_name/3" do
    setup do
      %{user: user_fixture()}
    end

    test "requires login_name to change", %{user: user} do
      {:error, changeset} =
        Accounts.apply_user_login_name(user, valid_user_password(), %{})

      assert %{login_name: ["did not change"]} = errors_on(changeset)
    end

    test "validates maximum value for login_name for security", %{user: user} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        Accounts.apply_user_login_name(user, valid_user_password(), %{
          login_name: too_long
        })

      assert "should be at most 160 character(s)" in errors_on(changeset).login_name
    end

    test "validates login_name uniqueness", %{user: user} do
      %{login_name: login_name} = user_fixture()

      {:error, changeset} =
        Accounts.apply_user_login_name(user, valid_user_password(), %{login_name: login_name})

      assert "has already been taken" in errors_on(changeset).login_name
    end

    test "validates current password", %{user: user} do
      {:error, changeset} =
        Accounts.apply_user_login_name(user, "invalid", %{login_name: unique_user_login_name()})

      assert %{current_password: ["is not valid"]} = errors_on(changeset)
    end

    test "applies the login_name without persisting it", %{user: user} do
      login_name = unique_user_login_name()

      {:ok, user} =
        Accounts.apply_user_login_name(user, valid_user_password(), %{login_name: login_name})

      assert user.login_name == login_name
      assert Accounts.get_user!(user.id).login_name != login_name
    end
  end

  describe "change_user_password/2" do
    test "returns a user changeset" do
      assert %Ecto.Changeset{} =
               changeset = Accounts.change_user_password(%User{})

      assert changeset.required == [:password]
    end

    test "allows fields to be set" do
      changeset =
        Accounts.change_user_password(%User{}, %{
          "password" => "new valid password"
        })

      assert changeset.valid?
      assert get_change(changeset, :password) == "new valid password"
      assert is_nil(get_change(changeset, :hashed_password))
    end
  end

  describe "update_user_password/3" do
    setup do
      %{user: user_fixture()}
    end

    test "validates password", %{user: user} do
      {:error, changeset} =
        Accounts.update_user_password(user, valid_user_password(), %{
          password: "not valid",
          password_confirmation: "another"
        })

      assert %{
               password: ["should be at least 12 character(s)"],
               password_confirmation: ["does not match password"]
             } = errors_on(changeset)
    end

    test "validates maximum values for password for security", %{user: user} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        Accounts.update_user_password(user, valid_user_password(), %{
          password: too_long
        })

      assert "should be at most 80 character(s)" in errors_on(changeset).password
    end

    test "validates current password", %{user: user} do
      {:error, changeset} =
        Accounts.update_user_password(user, "invalid", %{
          password: valid_user_password()
        })

      assert %{current_password: ["is not valid"]} = errors_on(changeset)
    end

    test "updates the password", %{user: user} do
      {:ok, user} =
        Accounts.update_user_password(user, valid_user_password(), %{
          password: "new valid password"
        })

      assert is_nil(user.password)

      assert Accounts.get_user_by_login_name_and_password(
               user.login_name,
               "new valid password"
             )
    end

    test "deletes all tokens for the given user", %{user: user} do
      _ = Accounts.generate_user_session_token(user)

      {:ok, _} =
        Accounts.update_user_password(user, valid_user_password(), %{
          password: "new valid password"
        })

      refute Repo.get_by(UserToken, user_id: user.id)
    end
  end

  describe "generate_user_session_token/1" do
    setup do
      %{user: user_fixture()}
    end

    test "generates a token", %{user: user} do
      token = Accounts.generate_user_session_token(user)
      assert user_token = Repo.get_by(UserToken, token: token)
      assert user_token.context == "session"

      # Creating the same token for another user should fail
      assert_raise Ecto.ConstraintError, fn ->
        Repo.insert!(%UserToken{
          token: user_token.token,
          user_id: user_fixture().id,
          context: "session"
        })
      end
    end
  end

  describe "get_user_by_session_token/1" do
    setup do
      user = user_fixture()
      token = Accounts.generate_user_session_token(user)
      %{user: user, token: token}
    end

    test "returns user by token", %{user: user, token: token} do
      assert session_user = Accounts.get_user_by_session_token(token)
      assert session_user.id == user.id
    end

    test "does not return user for invalid token" do
      refute Accounts.get_user_by_session_token("oops")
    end

    test "does not return user for expired token", %{token: token} do
      {1, nil} =
        Repo.update_all(UserToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])

      refute Accounts.get_user_by_session_token(token)
    end
  end

  describe "delete_session_token/1" do
    test "deletes the token" do
      user = user_fixture()
      token = Accounts.generate_user_session_token(user)
      assert Accounts.delete_session_token(token) == :ok
      refute Accounts.get_user_by_session_token(token)
    end
  end

  describe "inspect/2" do
    test "does not include password" do
      refute inspect(%User{password: "123456"}) =~ "password: \"123456\""
    end
  end
end
