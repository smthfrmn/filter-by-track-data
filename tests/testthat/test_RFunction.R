test_data <- test_data("input3_move2loc_LatLon.rds") |>
  mutate_track_data(
    sex = c("f", "f", "f", "f", "m"),
    test_date_str = format(deploy_off_timestamp)
  )



test_that("filter number tag_id ==", {
  actual <- rFunction(data = test_data, variab = "tag_id", rel = "==", valu = "1898887")
  expected_count <- 573
  expect_equal(nrow(actual), expected_count)
})

test_that("filter number tag_id >", {
  actual <- rFunction(data = test_data, variab = "tag_id", rel = ">", valu = "1898887")
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})


test_that("filter number tag_id <", {
  actual <- rFunction(data = test_data, variab = "tag_id", rel = "<", valu = "1898887")
  expected_count <- 364
  expect_equal(nrow(actual), expected_count)
})


test_that("filter factor tag_local_identifier ==", {
  actual <- rFunction(data = test_data, variab = "tag_local_identifier", rel = "==", valu = "40534")
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})


test_that("error filter factor tag_local_identifier >", {
  # actual <- rFunction(data = test_data, variab = "tag_local_identifier", rel = ">", valu = "40534")
  # expected_count <- 2232
  # expect_equal(nrow(actual), expected_count)
})


test_that("error filter factor tag_local_identifier <", {
  # actual <- rFunction(data = test_data, variab = "tag_local_identifier", rel = ">", valu = "40534")
  # expected_count <- 2232
  # expect_equal(nrow(actual), expected_count)
})


test_that("filter date deploy_off_timestamp ==", {
  actual <- rFunction(data = test_data, variab = "deploy_off_timestamp",
                      rel = "==", valu = "2006-12-23", time = TRUE)
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date deploy_off_timestamp >", {
  actual <- rFunction(data = test_data, variab = "deploy_off_timestamp",
                      rel = ">", valu = "2004-01-01", time = TRUE)
  expected_count <- 2805
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date deploy_off_timestamp <", {
  actual <- rFunction(data = test_data, variab = "deploy_off_timestamp",
                      rel = "<", valu = "2006-01-01", time = TRUE)
  expected_count <- 937
  expect_equal(nrow(actual), expected_count)
})


test_that("filter convert date test_date_str ==", {
  actual <- rFunction(data = test_data, variab = "test_date_str",
                      rel = "==", valu = "2006-01-01", time = TRUE)
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})


test_that("filter convert date test_date_str >", {
  actual <- rFunction(data = test_data, variab = "test_date_str",
                      rel = ">", valu = "2006-01-01", time = TRUE)
  expected_count <- 2805
  expect_equal(nrow(actual), expected_count)
})


test_that("filter convert date test_date_str <", {
  actual <- rFunction(data = test_data, variab = "test_date",
                      rel = "<", valu = "2006-01-01", time = TRUE)
  expected_count <- 937
  expect_equal(nrow(actual), expected_count)
})



test_that("error filter date non-date column", {
  actual <- rFunction(data = test_data, variab = "tag_id",
                      rel = "<", valu = "2006-01-01", time = TRUE)
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})






