URL_BASE <- "http://webservices.ns.nl/"
URL_STATIONS <- paste0(URL_BASE, "ns-api-stations-v2")
URL_DEPARTURES <- paste0(URL_BASE, "ns-api-avt")
URL_PLANNER <- paste0(URL_BASE, "ns-api-treinplanner")
URL_DISRUPTIONS <- paste0(URL_BASE, "ns-api-storingen")
URL_PRICES <- paste0(URL_BASE, "ns-api-prijzen-v3")

auth_cache <- new.env()

xml_cache <- new.env()

.onLoad <- function(libname, pkgname) {
  # set default options (if not already set)
  op <- options()
  op.nsapi <- list(
    nsapi.expire.after = 20, # expire after 20 ...
    nsapi.expire.units = "mins" # .. minutes
  )
  toset <- !(names(op.nsapi) %in% names(op))
  if(any(toset)) options(op.nsapi[toset])
  
  # try loading credential data from environment
  ns_user <- Sys.getenv("NS_USER")
  ns_pass <- Sys.getenv("NS_PASS")
  save.credentials(ns_user, ns_pass)
}

.onUnload <- function(libname, pkgname) {
  # delete cache files
  rm(list=ls( envir=auth_cache), envir=auth_cache)
  rm(list=ls( envir=xml_cache), envir=xml_cache)
}