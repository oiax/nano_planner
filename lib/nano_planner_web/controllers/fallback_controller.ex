defmodule NanoPlannerWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(NanoPlannerWeb.CustomErrorView)
    |> render("not_found.html")
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(NanoPlannerWeb.CustomErrorView)
    |> render("forbidden.html")
  end
end
