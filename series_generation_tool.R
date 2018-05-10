f <- function(total_len, middle, slope) {
  number_years = total_len / 2
  year_gaps_between_starting_and_median_year = (number_years - 1) / 2
  starting_value = middle - year_gaps_between_starting_and_median_year * slope
  for (e in 0: (number_years - 1)) {
    print(starting_value + e * slope)
    print(starting_value + e * slope)
  }
}

f_neg <- function(total_len, middle, slope) {
  number_years = total_len / 2
  year_gaps_between_starting_and_median_year = (number_years - 1) / 2
  starting_value = middle + year_gaps_between_starting_and_median_year * slope
  for (e in 0: (number_years - 1)) {
    print(starting_value + e * slope)
    print(starting_value + e * slope)
  }
}
