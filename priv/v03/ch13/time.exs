# time = Time.new!(10, 30, 0, {12345, 6})
time = ~T[10.30.00]
IO.inspect(time)
IO.inspect(time, structs: false)
