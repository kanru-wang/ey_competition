f = function(first, last, first_row, last_row) {
  duration = (1 + last_row - first_row) / 2
  interval = (last - first) / (duration + 1)
  for (e in 1:duration) {
    print(first + e * interval)
  }
}

up = function(earliest, three_y_later, first_row, last_row) {
  duration = (1 + last_row - first_row) / 2
  interval = (three_y_later - earliest) / 3
  for (e in duration:1) {
    print(earliest - e * interval)
  }
}

down = function(latest, three_y_earlier, first_row, last_row) {
  duration = (1 + last_row - first_row) / 2
  interval = (latest - three_y_earlier) / 3
  for (e in 1:duration) {
    print(latest + e * interval)
  }
}
