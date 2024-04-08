test_data <- test_data("input3_move2loc_LatLon.rds") |>
  mutate_track_data(
    sex = c("f", "f", "f", "u", "m"),
    test_date_str = format(deploy_off_timestamp),
    study_number_of_deployments = c(5, 5, 5, 5, 3)
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


test_that("filter date deploy_off_timestamp ==", {
  actual <- rFunction(
    data = test_data, variab = "deploy_off_timestamp",
    rel = "==", valu = "2006-12-23", time = TRUE
  )
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date deploy_off_timestamp >", {
  actual <- rFunction(
    data = test_data, variab = "deploy_off_timestamp",
    rel = ">", valu = "2004-01-01", time = TRUE
  )
  expected_count <- 2805
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date deploy_off_timestamp <", {
  actual <- rFunction(
    data = test_data, variab = "deploy_off_timestamp",
    rel = "<", valu = "2006-01-01", time = TRUE
  )
  expected_count <- 937
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date convert test_date_str ==", {
  actual <- rFunction(
    data = test_data, variab = "test_date_str",
    rel = "==", valu = "2006-12-23", time = TRUE
  )
  expected_count <- 2232
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date convert test_date_str >", {
  actual <- rFunction(
    data = test_data, variab = "test_date_str",
    rel = ">", valu = "2004-01-01", time = TRUE
  )
  expected_count <- 2805
  expect_equal(nrow(actual), expected_count)
})


test_that("filter date convert test_date_str <", {
  actual <- rFunction(
    data = test_data, variab = "test_date_str",
    rel = "<", valu = "2006-01-01", time = TRUE
  )
  expected_count <- 937
  expect_equal(nrow(actual), expected_count)
})


test_that("filter 'Other' non-integer works", {
  actual <- rFunction(
    data = test_data, variab = "other",
    other = "study_number_of_deployments",
    rel = "==", valu = '5'
  )
  expected_count <- 937
  expect_equal(nrow(actual), expected_count)
})


test_that("filter 'Other' integer works", {
  actual <- rFunction(
    data = test_data, variab = "other",
    other = "study_number_of_deployments",
    rel = "==", valu = 5
  )
  expected_count <- 937
  expect_equal(nrow(actual), expected_count)
})


test_that("error filter date non-date column", {
  actual <- rFunction(
    data = test_data, variab = "tag_id",
    rel = "<", valu = "2006-01-01", time = TRUE
  )
  expect_null(actual)
})


test_that("error missing variab", {
  actual <- rFunction(data = test_data, variab = " ", rel = "<", valu = "2006-01-01")
  expect_null(actual)
})


test_that("error missing rel", {
  actual <- rFunction(data = test_data, variab = "tag_id", rel = NULL, valu = "2006-01-01")
  expect_null(actual)
})


test_that("error missing valu", {
  actual <- rFunction(data = test_data, variab = "tag_id", rel = "<", valu = " ")
  expect_null(actual)
})



test_that("error unknown variab", {
  actual <- rFunction(
    data = test_data, variab = "unknown_variab",
    rel = "<", valu = "2006-01-01", time = TRUE
  )
  expect_null(actual)
})


test_that("error 'other' not set", {
  actual <- rFunction(
    data = test_data, variab = "other", other = NULL,
    rel = "<", valu = "2006-01-01", time = TRUE
  )
  expect_null(actual)
})


# test_that("error using > for non-numeric field", {
#   actual <- rFunction(
#     data = test_data, variab = "other", other = "death_comments",
#     rel = "<", valu = "2006-01-01", time = TRUE
#   ) 
#   expect_null(actual)
# })


test_that("filter by multiple strings", {
  actual <- rFunction(
    data = test_data, variab = "sex",
    rel = "%in%", valu = "m,f"
  )
  expected <- 2596
  expect_equal(expected, nrow(actual))
})
