defmodule NanoPlannerWeb.PlanItemView do
  use NanoPlannerWeb, :view
  alias Timex.Format.DateTime.Formatters.Strftime

  def format_duration(item) do
    [format_starts_at(item), "〜", format_ends_at(item)] |> Enum.join(" ")
  end

  defp format_starts_at(item) do
    time_zone = Application.get_env(:nano_planner, :default_time_zone)
    w = format_wday(item.starts_at)

    if item.starts_at.year == Timex.now(time_zone).year do
      Strftime.format!(item.starts_at, "%-m月%-d日 (#{w}) %H:%M")
    else
      Strftime.format!(item.starts_at, "%Y年%-m月%-d日 (#{w}) %H:%M")
    end
  end

  defp format_ends_at(item) do
    w = format_wday(item.ends_at)

    cond do
      Timex.to_date(item.ends_at) == Timex.to_date(item.starts_at) ->
        Strftime.format!(item.ends_at, "%H:%M")

      item.ends_at.year == item.starts_at.year ->
        Strftime.format!(item.ends_at, "%-m月%-d日 (#{w}) %H:%M")

      true ->
        Strftime.format!(item.ends_at, "%Y年%-m月%-d日 (#{w}) %H:%M")
    end
  end

  defp format_datetime(datetime) do
    w = format_wday(datetime)

    Strftime.format!(datetime, "%Y年%-m月%-d日 (#{w}) %H:%M")
  end

  @weekday_names ~w(日 月 火 水 木 金 土)
  defp format_wday(datetime) do
    Enum.at(@weekday_names, Timex.days_to_beginning_of_week(datetime, :sun))
  end
end
