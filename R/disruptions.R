XPATHS_UNPLANNED_DISRUPTIONS <- c(
  disruption.id = "id",
  disruption.segment = "Traject",
  disruption.cause = "Reden",
  disruption.message= "Bericht",
  disruption.date = "Datum"
)

XPATHS_PLANNED_DISRUPTIONS <- c(
  disruption.id = "id",
  disruption.segment = "Traject",
  disruption.period = "Periode",
  disruption.cause = "Reden",
  disruption.advice = "Advies",
  disruption.message= "Bericht"
)

get.disruptions <- function( station=NULL, actual=NULL, planned=NULL, ...) {
  xml.data <- download.disruptions(
    station=station, actual=actual, planned=planned
  )
  return( parse.disruptions(xml.data))
}

download.disruptions <- function(station=NULL, actual=NULL, planned=NULL, ...) {
  queries <- c()
  if (!is.null(station)) 
    queries <- c(queries, c("station"=station))
  if (!is.null(actual)) 
    queries <- c(queries, c("actual"=ifelse(actual == T, "true", "false")))
  if (!is.null(planned)) 
    queries <- c(queries, c("unplanned"=ifelse(planned == T, "true", "false")))
  if (length(queries) == 0) stop("Please use at least one query field")
  print(paste("Will use URL:", add.queries(URL_DISRUPTIONS, queries)))
  return(download( add.queries(URL_DISRUPTIONS, queries) , ...))
}

# @return list of two dataframes
parse.disruptions <- function(xml.data) {
  result <- vector(mode="list", length=2)
  xml.data <- 
  ## process unplanned disruptions
  result[[1]] <- as.data.frame.xml(
    xml.data,
    XPathsToColumns = XPATHS_DEPARTURES,
    XPathRoot = "Storingen/Ongepland"
  )
  ## process planned disruptions
  result[[2]] <- as.data.frame.xml(
    xml.data,
    XPathsToColumns = XPATHS_DEPARTURES,
    XPathRoot = "Storingen/Gepland"
  )
  names(result) <- c("Unplanned", "Planned")
  return(result)
}