defmodule NanoPlannerWeb.Router do
  use NanoPlannerWeb, :router
  use Plug.ErrorHandler

  @behaviour Plug.ErrorHandler

  import NanoPlannerWeb.UserAuth,
    only: [
      redirect_if_user_is_authenticated: 2,
      require_authenticated_user: 2
    ]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :pre_auth do
    plug NanoPlannerWeb.CurrentUser
    plug :redirect_if_user_is_authenticated
  end

  pipeline :restricted do
    plug NanoPlannerWeb.CurrentUser
    plug :require_authenticated_user
  end

  scope "/", NanoPlannerWeb do
    pipe_through :browser

    get "/lessons/form", LessonController, :form
    get "/lessons/register", LessonController, :register
    get "/lessons/hello", LessonController, :hello
    get "/cookie", CookieController, :show
    get "/cookie/set", CookieController, :set
    get "/cookie/unset", CookieController, :unset
    get "/session", SessionController, :show
    get "/session/set", SessionController, :set
    get "/session/unset", SessionController, :unset
    get "/plug", PlugController, :show
  end

  scope "/", NanoPlannerWeb do
    pipe_through [:browser, NanoPlannerWeb.CurrentUser]

    get "/", TopController, :index
  end

  scope "/", NanoPlannerWeb do
    pipe_through [:browser, :pre_auth]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", NanoPlannerWeb do
    pipe_through [:browser, :restricted]

    scope "/plan_items" do
      get "/of_today", PlanItemController, :of_today
    end

    resources "/plan_items", PlanItemController
    delete "/users/log_out", UserSessionController, :delete
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: :error, reason: %Ecto.NoResultsError{}}) do
    send_resp(conn, conn.status, "Something went wrong")
  end

  def handle_errors(conn, %{}) do
    conn
  end
end
