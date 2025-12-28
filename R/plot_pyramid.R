#' Draw a Population Pyramid
#'
#' @description
#' Generates a population pyramid plot for demographic data (like `pop7str`).
#' It transforms the data into a format suitable for `ggplot2`,
#' negates male population values for symmetric visualization,
#' and applies a customizable color scheme.
#'
#' @param data A tibble or dataframe. Expected to have Age in the first column,
#' followed by male and female population columns (e.g., "Male", "Female").
#' @param colors A character vector of length 2. The first color corresponds to males,
#' and the second to females. Defaults to c("steelblue", "orange").
#'
#' @return A ggplot object representing the population pyramid.
#'
#' @export
#'
#' @examples
#' data(pop7str)
#' plot_pyramid(pop7str)
#' plot_pyramid(pop7str, colors = c("blue", "red"))
#'
#' @importFrom stats setNames

plot_pyramid = function(data, colors = c("steelblue", "orange")) {
  # Prepare data for visualization
  plot_data = data |>
    setNames(c("Age", "Male", "Female")) |>
    tidyr::pivot_longer(-Age, names_to = "Gender", values_to = "pop") |>
    dplyr::mutate(pop = ifelse(Gender == "Male", -pop, pop),
                  Age = forcats::as_factor(Age))
  # Create the plot
  plot_data |>
    ggplot2::ggplot(ggplot2::aes(Age, pop, fill = Gender)) +
    ggplot2::geom_col() +
    ggplot2::scale_y_continuous(labels = abs) +
    ggplot2::scale_fill_manual(values = c("Male" = colors[1],
                                          "Female" = colors[2])) +
    ggplot2::ylab("Population (M)") +
    ggplot2::coord_flip() +
    ggplot2::theme_minimal()
}

utils::globalVariables(c("Age", "Gender", "pop"))
