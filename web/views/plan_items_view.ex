defmodule NanoPlanner.PlanItemsView do
  use NanoPlanner.Web, :view
  import Timex.Format.DateTime.Formatters.Strftime, only: [format!: 2]

  def format_duration(item) do
    [
      format_datetime(item.starts_at),
      "～",
      format_datetime(item.ends_at)
    ] |> Enum.join
  end

  defp format_datetime(time) do
    time |> Timex.Timezone.convert("Asia/Tokyo")
      |> format!("%Y年%-m月%-d日 %H:%M")
  end
end
