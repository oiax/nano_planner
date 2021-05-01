datetime = DateTime.now!("Asia/Tokyo")

wday =
  datetime
  |> DateTime.to_date()
  |> Date.day_of_week()
  |> rem(7)

IO.inspect(datetime)
IO.inspect(wday)
