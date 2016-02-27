library(nsapi)
context("Stations data")

test_that("Get stations data",{
  # test get.stations
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
  df <- get.stations()
  expect_is(df, "data.frame")
  expect_identical(get.stations(), df)
})

test_that("Download stations data", {
  # test download.stations
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
  xml <- get.stations.xml()
  expect_is(xml, "xml_document")
  expect_identical(download.stations(), xml)
})

test_that("Parse Stations XML", {
  # test parse.stations
})