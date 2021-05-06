defmodule NanoPlannerWeb.PlanItemView do
  use NanoPlannerWeb, :view
  alias Timex.Format.DateTime.Formatters.Strftime

  def format_duration(item) do
    Enum.join([format_starts_at(item), "～", format_ends_at(item)], " ")
  end

  defp format_starts_at(item) do
    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    if item.starts_at.year == DateTime.now!(time_zone).year do
      Strftime.format!(item.starts_at, "%-m月%-d日 %H:%M")
    else
      Strftime.format!(item.starts_at, "%Y年%-m月%-d日 %H:%M")
    end
  end

  defp format_ends_at(item) do
    cond do
      DateTime.to_date(item.ends_at) == DateTime.to_date(item.starts_at) ->
        Strftime.format!(item.ends_at, "%H:%M")

      item.ends_at.year == item.starts_at.year ->
        Strftime.format!(item.ends_at, "%-m月%-d日 %H:%M")

      true ->
        Strftime.format!(item.ends_at, "%Y年%-m月%-d日 %H:%M")
    end
  end
end
