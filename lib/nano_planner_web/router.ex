defmodule NanoPlannerWeb.Router do
  use NanoPlannerWeb, :router

  def after_action_callback(conn, _opts) do
    Plug.Conn.register_before_send(conn, fn conn ->
      IO.puts "== AFTER ACTION =="
      conn
    end)
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(NanoPlannerWeb.CounterPlug)
    plug(:after_action_callback)
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
