defmodule NanoPlanner.Web.Router do
  use NanoPlanner.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", NanoPlanner.Web do
    pipe_through :browser

    get "/", TopController, :index
    get "/plan_items", PlanItemController, :index
    get "/plan_items/new", PlanItemController, :new
    get "/plan_items/:id", PlanItemController, :show
    post "/plan_items", PlanItemController, :create
  end
end
