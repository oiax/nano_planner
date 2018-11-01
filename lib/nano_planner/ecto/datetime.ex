defmodule NanoPlanner.Ecto.Datetime do
  @behaviour Ecto.Type

  @impl Ecto.Type
  def type, do: :datetime

  @impl Ecto.Type
  def cast(%DateTime{} = dt), do: {:ok, dt}
  def cast(_), do: :error

  @impl Ecto.Type
  def load(%NaiveDateTime{} = ndt), do: DateTime.from_naive(ndt, "Etc/UTC")
  def load(_), do: :error

  @impl Ecto.Type
  def dump(%DateTime{} = datetime) do
    case Timex.Timezone.convert(datetime, "Etc/UTC") do
      %DateTime{} = dt -> {:ok, dt}
      {:error, _} -> :error
    end
  end

  def dump(_), do: :error
end
