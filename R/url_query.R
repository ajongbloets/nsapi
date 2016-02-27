encode <- function(x) {
  if (inherits(x, "AsIs")) return(x)
  curl::curl_escape(x)
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
  value <- encode(value)
  if (!is.null(name) && name != "") value <- paste( curl::curl_escape(name), value, sep="=" )
  return(
    paste( url, value, sep=sep)
  )
}
