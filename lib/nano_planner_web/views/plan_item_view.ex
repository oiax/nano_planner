defmodule NanoPlannerWeb.PlanItemView do
  use NanoPlannerWeb, :view
  alias Timex.Format.DateTime.Formatters.Strftime
  alias NanoPlanner.Schedule.PlanItem

  def document_title(assigns) do
    page_title =
      case assigns.view_template do
        "index.html" -> "予定表"
        "of_today.html" -> "今日の予定表"
        "show.html" -> "予定の詳細"
        "new.html" -> "予定の追加"
        "edit.html" -> "予定の変更"
        _ -> nil
      end

    if page_title do
      "#{page_title} - NanoPlanner"
    else
      "NanoPlanner"
    end
  end

  def format_duration(%PlanItem{all_day: false} = item) do
    [format_starts_at(item), "～", format_ends_at(item)] |> Enum.join(" ")
  end

  def format_duration(%PlanItem{all_day: true} = item) do
    if item.starts_on == item.ends_on do
      format_starts_on(item)
    else
      [format_starts_on(item), "～", format_ends_on(item)] |> Enum.join(" ")
    end
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

  defp format_starts_on(item) do
    time_zone = Application.get_env(:nano_planner, :default_time_zone)
    w = format_wday(item.starts_at)

    if item.starts_at.year == Timex.now(time_zone).year do
      Strftime.format!(item.starts_on, "%-m月%-d日 (#{w})")
    else
      Strftime.format!(item.starts_on, "%Y年%-m月%-d日 (#{w})")
    end
  end

  defp format_ends_on(item) do
    w = format_wday(item.ends_at)

    if item.ends_at.year == item.starts_at.year do
      Strftime.format!(item.ends_at, "%-m月%-d日 (#{w})")
    else
      Strftime.format!(item.ends_at, "%Y年%-m月%-d日 (#{w})")
    end
  end

  def format_datetime(datetime) do
    w = format_wday(datetime)
    Strftime.format!(datetime, "%Y年%-m月%-d日 (#{w}) %H:%M")
  end

  @weekday_names ~w(日 月 火 水 木 金 土)
  defp format_wday(datetime) do
    Enum.at(@weekday_names, Timex.days_to_beginning_of_week(datetime, :sun))
  end

  def select_for_hours(form, field) do
    options = Enum.map(0..23, &{two_digits(&1), &1})
    select(form, field, options, class: "form-control", required: true)
  end

  def select_for_minutes(form, field) do
    options =
      0..11
      |> Enum.map(&(&1 * 5))
      |> Enum.map(&{two_digits(&1), &1})

    select(form, field, options, class: "form-control", required: true)
  end

  defp two_digits(n) do
    n |> Integer.to_string() |> String.pad_leading(2, "0")
  end

  @action_label_map %{
    index: "予定表",
    of_today: "今日の予定表"
  }
  def nav_link(conn, action) do
    class =
      if Phoenix.Controller.action_name(conn) == action do
        "nav-link active"
      else
        "nav-link"
      end

    link(
      @action_label_map[action],
      to: Routes.plan_item_path(conn, action),
      class: class
    )
  end
end
