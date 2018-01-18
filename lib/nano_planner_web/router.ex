defmodule NanoPlannerWeb.Router do
  use NanoPlannerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", NanoPlannerWeb do
    pipe_through(:browser)

    get("/", TopController, :index)
    get("/lessons/form", LessonController, :form)
    get("/lessons/register", LessonController, :register)
    get("/lessons/hello", LessonController, :hello)

    resources("/plan_items", PlanItemController)
  end
end
