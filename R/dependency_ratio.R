#' Calculate Dependency Ratio
#'
#' @description
#' Calculates the total dependency ratio for a given population dataset.
#' It parses age strings (e.g., "0-4") to extract numeric age ranges,
#' then divides the sum of the non-working-age population (0-14 and 65+)
#' by the sum of the working-age population (15-64).
#'
#' @param data A tibble or dataframe containing age and population data.
#' @param age The name of the column containing age groups (supports strings like "0-4").
#' @param pop The name of the column containing population counts.
#'
#' @return A numeric scalar representing the dependency ratio (e.g., 0.45).
#'
#' @export
#'
#' @examples
#' # Example using population from the pop7str dataset
#' data(pop7str)
#' pop7str$pop = pop7str$Male + pop7str$Female
#' dependency_ratio(pop7str, Age, pop)

dependency_ratio = function(data, age, pop) {
  data |>
    dplyr::mutate(x = readr::parse_number({{age}})) |>
    dplyr::summarise(ratio = sum({{pop}}[!(x > 14 & x < 65)]) /
                       sum({{pop}}[(x > 14 & x < 65)])) |>
    dplyr::pull(ratio)
}

utils::globalVariables(c("x", "ratio"))
