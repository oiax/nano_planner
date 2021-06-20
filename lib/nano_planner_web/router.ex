defmodule NanoPlannerWeb.Router do
  use NanoPlannerWeb, :router

  import NanoPlannerWeb.UserAuth

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

    scope "/plan_items" do
      get "/of_today", PlanItemController, :of_today
    end

    resources "/plan_items", PlanItemController
  end

  ## Authentication routes

  scope "/", NanoPlannerWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", NanoPlannerWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
  end

  scope "/", NanoPlannerWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end
