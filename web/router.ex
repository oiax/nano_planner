defmodule NanoPlanner.Router do
  use NanoPlanner.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", NanoPlanner do
    pipe_through :browser

    get "/", TopController, :index
    get "/lessons/form", LessonsController, :form
    get "/lessons/register", LessonsController, :register
    resources "/plan_items", PlanItemsController
  end
end
