library(nsapi)
context("Download data")

test_that("Download with cache", {
  url <- URL_STATIONS
  expect_error(download( url, ns.user = NULL, ns.pass =  NULL ) )
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
  xml <- download(url)
  expect_is(xml, "xml_document")
  expect_true(is.cached(url))
  expect_identical(download(url), xml)
})

test_that("Download XML", {
  url <- URL_STATIONS
  expect_error(download.xml( url, ns.user = NULL, ns.pass =  NULL ) )
  if ( is.null(auth_cache$NS_USER) || is.null(auth_cache$NS_PASS )) {
    skip("Credentials not available")
  }
  expect_is(download.xml(url), "xml_document")
})

test_that("Add query to url", {
  url <- "url"
  expect_equal(add.query(url, value=""), paste0(url, "?"))
  expect_equal(add.query(url, value="a"), paste0(url, "?a"))
  expect_equal(add.query(url, value="a", name="a"), paste0(url, "?a=a"))
  url <- "url?a"
  expect_equal(add.query(url, value=""), paste0(url, "&"))
  expect_equal(add.query(url, value="b"), paste0(url, "&b"))
  expect_equal(add.query(url, value="b", name="b"), paste0(url, "&b=b"))
})

test_that("Add queries to url", {
  url <- "url"
  expect_equal(add.queries(url, ""), paste0(url, "?"))
  expect_equal(add.queries(url, "a"), paste0(url, "?a"))
  expect_equal(add.queries(url, c("a")), paste0(url, "?a"))
  expect_equal(add.queries(url, queries=c("a", "b")), "url?a&b")
  expect_equal(add.queries(url, queries=c(a="a")), paste0(url, "?a=a"))
  expect_equal(add.queries(url, queries=c("a", b="b")), "url?a&b=b")
})

test_that("Add items to cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_true(exists(name, envir = test_cache, inherits = F))
  rm(name, envir=test_cache)
  add.cache(name, value="hallo")
  expect_true(exists(name, envir = xml_cache, inherits = F))
  rm(name, envir=xml_cache)
  add.cache(name, value="hallo", envir=xml_cache)
  expect_true(exists(name, envir = xml_cache, inherits = F))
  rm(name, envir=xml_cache)
})

test_that("Are items in cache?", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_true(is.cached(name, envir = test_cache))
  expect_false(is.cached(name))
  rm(name, envir=test_cache)
  expect_false(is.cached(name, envir = test_cache))
})

test_that("Remove items to cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_true(is.cached(name, envir = test_cache))
  remove.cache(name, envir=test_cache)
  expect_false(is.cached(name, envir = test_cache))
  expect_error(remove.cache(name, envir = test_cache))
})

test_that("Remove items to cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_true(is.cached(name, envir = test_cache))
  remove.cache(name, envir=test_cache)
  expect_false(is.cached(name, envir = test_cache))
  expect_error(remove.cache(name, envir = test_cache))
})

test_that("Retrieve from cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_named(retrieve.cache(name, envir=test_cache), c("time", "content") )
  expect_equal(retrieve.cache(name, envir=test_cache)$content, value )
  remove.cache(name, envir=test_cache)
  expect_error(retrieve.cache(name, envir=test_cache))
})

test_that("Retrieve time from cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_is(retrieve.cache.time(name, envir=test_cache), "POSIXct" )
  remove.cache(name, envir=test_cache)
  expect_error(retrieve.cache.time(name, envir=test_cache))
})

test_that("Retrieve content from cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_equal(retrieve.cache.content(name, envir=test_cache), value )
  remove.cache(name, envir=test_cache)
  expect_error(retrieve.cache.content(name, envir=test_cache))
})

test_that("Test experation time in cache", {
  name <- "name"
  test_cache <- new.env()
  value <- "hallo"
  add.cache(name, value=value, envir=test_cache)
  expect_false(is.expired(name, envir=test_cache, expire.after = 1))
  remove.cache(name, envir=test_cache)
  expect_error(retrieve.cache.content(name, envir=test_cache))
  add.cache(name, value=value, envir=test_cache)
  Sys.sleep(2)
  expect_true(is.expired(name, envir=test_cache, expire.after = 1, units="secs"))
  remove.cache(name, envir=test_cache)
})