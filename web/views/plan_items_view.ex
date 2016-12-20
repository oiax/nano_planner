defmodule NanoPlanner.PlanItemsView do
  use NanoPlanner.Web, :view
  import Timex.Format.DateTime.Formatters.Strftime, only: [format!: 2]

  @timezone "Asia/Tokyo"

  def format_duration(item) do
    [
      format_starts_at(item),
      "～",
      format_ends_at(item)
    ] |> Enum.join
  end

  defp format_starts_at(item) do
    s = item.starts_at |> Timex.Timezone.convert(@timezone)
    if s.year == Timex.now(@timezone).year do
      s |> format!("%-m月%-d日 %H:%M")
    else
      s |> format!("%Y年%-m月%-d日 %H:%M")
    end
  end

  defp format_ends_at(item) do
    s = item.starts_at |> Timex.Timezone.convert(@timezone)
    e = item.ends_at |> Timex.Timezone.convert(@timezone)
    cond do
      Timex.to_date(e) == Timex.to_date(s) ->
        e |> format!("%H:%M")
      e.year == s.year ->
        e |> format!("%-m月%-d日 %H:%M")
      true ->
        e |> format!("%Y年%-m月%-d日 %H:%M")
    end
  end
end
