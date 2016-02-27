library(nsapi)
context("Departures API")

test_that("Get departures for Utrecht",{
  # test get.departures
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
})

test_that("Download departures XML for Utrecht", {
  # test download.departures
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
  xml <- download.departures(station = "ut")
  expect_is(xml, "xml_document")
  expect_identical(download.departures(station = 'ut'), xml)
  expect_identical(download.departures(station = 'Utrecht C'), xml)
  expect_identical(download.departures(station = 'Utrecht C.'), xml)
  expect_identical(download.departures(station = 'Utrecht Centraal'), xml)
})

test_that("Parse departures XML", {
  # test parse.departures
})