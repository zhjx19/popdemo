test_that("plot_pyramid returns a ggplot object", {
  data(pop7str)
  p = plot_pyramid(pop7str)
  expect_s3_class(p, "gg")
})
