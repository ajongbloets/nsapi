#' General XML download function with cache option
download <- function(
  url, ns.user=auth_cache$NS_USER, ns.pass=auth_cache$NS_PASS, 
  use.cache=T, ... 
) {
  result <- NULL
  expire.after <- getOption("nsapi.expire.after")
  expire.units <- getOption("nsapi.expire.units")
  if (use.cache && 
      is.cached(url) && 
      !is.expired(url, expire.after = expire.after, units=expire.units)
  ) {
    result <- retrieve.cache.content(url)
  } else {
    result <- download.xml( url=url, ns.user=ns.user, ns.pass=ns.pass, ...)
    add.cache(url, result)
  }
  return(result)
}

# Downloads XML from an URL
download.xml <- function( 
  url, ns.user=auth_cache$NS_USER, ns.pass=auth_cache$NS_PASS, ... 
) {
  if (is.null(ns.user) || is.null(ns.pass)) {
    stop("Authentication is not set. 
         Use save.credentials or supply appropriate arguments")
  }
  # do request
  req <- httr::GET( url, httr::authenticate(ns.user, ns.pass), ... )
  httr::stop_for_status(req)
  return(xml2::read_xml(httr::content(req, type="raw")))
}

add.queries <- function( url, queries) {
  if (length(queries) == 0) {
    stop("No queries given. Please provide me with some queries")
  }
  for (idx in c(1:length(queries))) {
    url <- add.query( url, queries[[idx]], names(queries)[[idx]] )
  }
  return(url)
}

add.query <- function( url, value, name=NULL ) {
  sep <- "?"
  if (regexpr("\\?", url)[1] >= 0) sep <- "&"
  if (!is.null(name) && name != "") value <- paste( name, value, sep="=" )
  return(
    paste( url, value, sep=sep)
  )
}

add.cache <- function(name, value, replace=T, envir=xml_cache) {
  assign(name, value=list( time = Sys.time(), content=value ), envir=envir)
}

is.cached <- function(name, envir=xml_cache) {
  return(exists( name, envir=envir, inherits = F ))
}

remove.cache <- function(name, envir=xml_cache) {
  if (!is.cached(name, envir=envir)) stop(paste("No cache with name", name))
  rm(name, envir = envir)
}

clear.cache <- function(envir=xml_cache) {
  rm(list=ls(envir = envir), envir=envir)
}

retrieve.cache <- function(name, envir=xml_cache) {
  if (!is.cached(name, envir=envir)) stop(paste("No cache with name", name))
  return(get(name, envir=envir))
}

retrieve.cache.time <- function(name, envir=xml_cache) {
  value <- retrieve.cache(name, envir)
  return( value$time )
}

retrieve.cache.content <- function(name, envir=xml_cache) {
  value <- retrieve.cache(name, envir)
  return( value$content )
}

is.expired <- function (name, expire.after, units="mins", envir=xml_cache) {
  cache.time <- retrieve.cache.time(name, envir=envir)
  return( difftime(Sys.time(), cache.time, units = units) > expire.after )
}