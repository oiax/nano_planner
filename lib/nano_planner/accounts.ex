defmodule NanoPlanner.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias NanoPlanner.Repo

  alias NanoPlanner.Accounts.{User, UserToken}

  ## Database getters

  @doc """
  Gets a user by login_name.

  ## Examples

      iex> get_user_by_login_name("foo@example.com")
      %User{}

      iex> get_user_by_login_name("unknown@example.com")
      nil

  """
  def get_user_by_login_name(login_name) when is_binary(login_name) do
    Repo.get_by(User, login_name: login_name)
  end

  @doc """
  Gets a user by login_name and password.

  ## Examples

      iex> get_user_by_login_name_and_password("foo@example.com", "correct_password")
      %User{}

      iex> get_user_by_login_name_and_password("foo@example.com", "invalid_password")
      nil

  """
  def get_user_by_login_name_and_password(login_name, password)
      when is_binary(login_name) and is_binary(password) do
    user = Repo.get_by(User, login_name: login_name)
    if User.valid_password?(user, password), do: user
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  ## User registration

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user_registration(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user_registration(%User{} = user, attrs \\ %{}) do
    User.registration_changeset(user, attrs, hash_password: false)
  end

  ## Settings

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the user login_name.

  ## Examples

      iex> change_user_login_name(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user_login_name(user, attrs \\ %{}) do
    User.login_name_changeset(user, attrs)
  end

  @doc """
  Emulates that the login_name will change without actually changing
  it in the database.

  ## Examples

      iex> apply_user_login_name(user, "valid password", %{login_name: ...})
      {:ok, %User{}}

      iex> apply_user_login_name(user, "invalid password", %{login_name: ...})
      {:error, %Ecto.Changeset{}}

  """
  def apply_user_login_name(user, password, attrs) do
    user
    |> User.login_name_changeset(attrs)
    |> User.validate_current_password(password)
    |> Ecto.Changeset.apply_action(:update)
  end

  @doc """
  Updates the user login_name using the given token.

  If the token matches, the user login_name is updated and the token is deleted.
  The confirmed_at date is also updated to the current time.
  """
  def update_user_login_name(user, token) do
    context = "change:#{user.login_name}"

    with {:ok, query} <-
           UserToken.verify_change_login_name_token_query(token, context),
         %UserToken{sent_to: login_name} <- Repo.one(query),
         {:ok, _} <- Repo.transaction(user_login_name_multi(user, login_name, context)) do
      :ok
    else
      _ -> :error
    end
  end

  defp user_login_name_multi(user, login_name, context) do
    changeset =
      user |> User.login_name_changeset(%{login_name: login_name}) |> User.confirm_changeset()

    Ecto.Multi.new()
    |> Ecto.Multi.update(:user, changeset)
    |> Ecto.Multi.delete_all(
      :tokens,
      UserToken.user_and_contexts_query(user, [context])
    )
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the user password.

  ## Examples

      iex> change_user_password(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user_password(user, attrs \\ %{}) do
    User.password_changeset(user, attrs, hash_password: false)
  end

  @doc """
  Updates the user password.

  ## Examples

      iex> update_user_password(user, "valid password", %{password: ...})
      {:ok, %User{}}

      iex> update_user_password(user, "invalid password", %{password: ...})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_password(user, password, attrs) do
    changeset =
      user
      |> User.password_changeset(attrs)
      |> User.validate_current_password(password)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:user, changeset)
    |> Ecto.Multi.delete_all(
      :tokens,
      UserToken.user_and_contexts_query(user, :all)
    )
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user}} -> {:ok, user}
      {:error, :user, changeset, _} -> {:error, changeset}
    end
  end

  ## Session

  @doc """
  Generates a session token.
  """
  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  @doc """
  Gets the user with the given signed token.
  """
  def get_user_by_session_token(token) do
    {:ok, query} = UserToken.verify_session_token_query(token)
    Repo.one(query)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_session_token(token) do
    Repo.delete_all(UserToken.token_and_context_query(token, "session"))
    :ok
  end
end
