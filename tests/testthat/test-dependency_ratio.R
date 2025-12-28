test_that("dependency_ratio calculation logic", {
  # minimal dataset
  test_data = tibble::tibble(
    age = c("0-4", "20-24", "70-74"),
    male = c(100, 200, 100))

  expected_ratio = 1.0
  result = dependency_ratio(test_data, age, male)

  expect_equal(result, expected_ratio)
})
