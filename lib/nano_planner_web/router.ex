defmodule NanoPlannerWeb.Router do
  use NanoPlannerWeb, :router

  import NanoPlannerWeb.UserAuth,
    only: [
      fetch_current_user: 1,
      redirect_if_user_is_authenticated: 1,
      require_authenticated_user: 1
    ]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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
  end

  scope "/", NanoPlannerWeb do
    pipe_through [:browser, :fetch_current_user]
    get "/", TopController, :index
  end

  scope "/", NanoPlannerWeb do
    pipe_through [
      :browser,
      :fetch_current_user,
      :redirect_if_user_is_authenticated
    ]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", NanoPlannerWeb do
    pipe_through [
      :browser,
      :fetch_current_user,
      :require_authenticated_user
    ]

    scope "/plan_items" do
      get "/of_today", PlanItemController, :of_today
    end

    resources "/plan_items", PlanItemController
  end
end
