# Define Xpath - Column relation
XPATHS_DEPARTURES <- c(
  train.id = "RitNummer",
  departure.time = "VertrekTijd",
  departure.delay = "VertrekVertraging",
  departure.delay.text = "VertrekVertragingTekst",
  final.destination = "EindBestemming",
  type = "TreinSoort",
  route.text = "RouteTekst",
  transporter = "Vervoerder",
  departure.platform = "VertrekSpoor",
  departure.platform.change = "VertrekSpoor/@wijziging",
  travel.tip = "ReisTip",
  remarkts = "Opmerkingen"
)

TYPES_DEPARTURES <- c(
  train.id = as.integer
)

get.departures <- function(station, ...) {
  xml.data <- download.departures(station, ...)
  return( parse.departures(xml.data) )
}

download.departures <- function(station, ...) {
  return( download( add.query(URL_DEPARTURES, station, "station"), ...))
}

parse.departures <- function( xml.data ) {
  return(
    as.data.frame.xml(
      xml.data,
      columns_xpaths = XPATHS_DEPARTURES,
      root_xpath = "ActueleVertrekTijden/VertrekkendeTrein"
    )
  )
}