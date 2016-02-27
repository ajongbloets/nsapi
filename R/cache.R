
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