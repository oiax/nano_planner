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
    resources "/plan_items", PlanItemController,
      only: [:index, :new, :show, :create, :edit, :update]
  end
end
