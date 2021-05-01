defmodule NanoPlannerWeb.LayoutView do
  use NanoPlannerWeb, :view

  def this_year do
    time_zone = Application.get_env(:nano_planner, :default_time_zone)
    DateTime.now!(time_zone).year
  end
end
