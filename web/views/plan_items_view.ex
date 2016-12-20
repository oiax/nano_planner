defmodule NanoPlanner.PlanItemsView do
  use NanoPlanner.Web, :view
  alias Timex.Format.DateTime.Formatters.Strftime

  @timezone "Asia/Tokyo"

  def format_duration(item) do
    [format_starts_at(item), "～", format_ends_at(item)] |> Enum.join
  end

  defp format_starts_at(item) do
    if item.starts_at.year == Timex.now(@timezone).year do
      Strftime.format!(item.starts_at, "%-m月%-d日 %H:%M")
    else
      Strftime.format!(item.starts_at, "%Y年%-m月%-d日 %H:%M")
    end
  end

  defp format_ends_at(item) do
    cond do
      Timex.to_date(item.ends_at) == Timex.to_date(item.starts_at) ->
        Strftime.format!(item.ends_at, "%H:%M")
      item.ends_at.year == item.starts_at.year ->
        Strftime.format!(item.ends_at, "%-m月%-d日 %H:%M")
      true ->
        Strftime.format!(item.ends_at, "%Y年%-m月%-d日 %H:%M")
    end
  end
end
