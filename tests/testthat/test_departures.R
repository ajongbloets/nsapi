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
  expect_is(xml, "")
  expect_identical(download.departures(station = 'ut'), xml)
  expect_is(download.departures(station = "Utrecht C"), "xml_document")
  expect_is(download.departures(station = "Utrecht C."), "xml_document")
  expect_is(download.departures(station = "Utrecht Centraal"), "xml_document")
})

test_that("Parse departures XML", {
  # test parse.departures
  xml.data <- xml2::read_xml("departures_ut.xml")
  df.data <- parse.departures(xml.data)
  expect_equal(nrow(df.data), 48)
  expect_equal(df.data[1, "train.id"], 3167)
  expect_equal(df.data[1, "type"], "knooppuntIntercitystation")
})