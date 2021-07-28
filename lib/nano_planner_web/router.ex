defmodule NanoPlannerWeb.Router do
  use NanoPlannerWeb, :router
  import NanoPlannerWeb.UserAuth, only: [fetch_current_user: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  scope "/", NanoPlannerWeb do
    pipe_through :browser

    get "/", TopController, :index
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

    scope "/plan_items" do
      get "/of_today", PlanItemController, :of_today
    end

    resources "/plan_items", PlanItemController

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end
end
