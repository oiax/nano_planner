defmodule NanoPlanner.PlanItemsView do
  use NanoPlanner.Web, :view
  alias Timex.Format.DateTime.Formatters.Strftime

  @application_name "NanoPlanner"
  def document_title(view_template, assigns) do
    prefix = case view_template do
      "index.html" ->
        case assigns.conn.private.phoenix_action do
          :index -> "予定表"
          :of_today -> "今日の予定表"
        end
      "new.html" -> "予定の追加"
      "show.html" -> "予定の詳細"
      "edit.html" -> "予定の変更"
      _ -> ""
    end

    case prefix do
      "" -> @application_name
      prefix -> prefix <> " | " <> @application_name
    end
  end

  @action_label_map %{
    index: "予定表",
    of_today: "今日の予定表",
  }
  def plan_items_nav_link(conn, action) do
    css_class = if conn.private.phoenix_action == action do
      "nav-link active"
    else
      "nav-link"
    end

    link @action_label_map[action], to: plan_items_path(conn, action),
      class: css_class
  end

  def format_duration(item) do
    [format_starts_at(item), "～", format_ends_at(item)] |> Enum.join(" ")
  end

  defp format_starts_at(item) do
    w = format_wday(item.starts_at)
    time_zone = Application.get_env(:nano_planner, :default_time_zone)
    if item.starts_at.year == Timex.now(time_zone).year do
      Strftime.format! item.starts_at, "%-m月%-d日 (#{w}) %H:%M"
    else
      Strftime.format! item.starts_at, "%Y年%-m月%-d日 (#{w}) %H:%M"
    end
  end

  defp format_ends_at(item) do
    w = format_wday(item.ends_at)
    cond do
      Timex.to_date(item.ends_at) == Timex.to_date(item.starts_at) ->
        Strftime.format! item.ends_at, "%H:%M"
      item.ends_at.year == item.starts_at.year ->
        Strftime.format! item.ends_at, "%-m月%-d日 (#{w}) %H:%M"
      true ->
        Strftime.format! item.ends_at, "%Y年%-m月%-d日 (#{w}) %H:%M"
    end
  end

  def format_datetime(datetime) do
    w = format_wday(datetime)
    Strftime.format! datetime, "%Y年%-m月%-d日 (#{w}) %H:%M"
  end

  defp format_wday(datetime) do
    Enum.at ~w(日 月 火 水 木 金 土),
      Timex.days_to_beginning_of_week(datetime, :sun)
  end

  def select_for_hours(form, field) do
    values = 0..23
    options = Enum.map(values, &{two_digits(&1), &1})
    select form, field, options, class: "form-control", required: true
  end

  def select_for_minutes(form, field) do
    values = Enum.map(0..11, &(&1 * 5))
    options = Enum.map(values, &{two_digits(&1), &1})
    select form, field, options, class: "form-control", required: true
  end

  defp two_digits(n) do
    n |> Integer.to_string |> String.pad_leading(2, "0")
  end

  def form_group(form, field, [do: block]) do
    class = if form.errors[field] do
      "form-group has-danger"
    else
      "form-group"
    end
    content_tag(:div, [class: class], [do: block])
  end
end
