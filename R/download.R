#' General XML download function with cache option
download <- function(
  url, ns.user=auth_cache$NS_USER, ns.pass=auth_cache$NS_PASS,  ... 
) {
  result <- NULL
  expire.after <- getOption("nsapi.cache.expire.after")
  expire.units <- getOption("nsapi.cache.expire.units")
  if (getOption("nsapi.cache") && 
      is.cached(url) && 
      !is.expired(url, expire.after = expire.after, units=expire.units)
  ) {
    result <- retrieve.cache.content(url)
  } else {
    result <- download.xml( url=url, ns.user=ns.user, ns.pass=ns.pass, ...)
    if (getOption("nsapi.cache")) add.cache(url, result)
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
