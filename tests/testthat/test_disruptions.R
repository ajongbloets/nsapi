library(nsapi)
context("Disruptions API")

test_that("Get disruptions for Utrecht",{
  # test get.disruptions
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
})

test_that("Download dispruptions XML for Utrecht", {
  # test download.disruptions
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
  
})

test_that("Parse disruptions XML", {
  # test parse.disruptions
})