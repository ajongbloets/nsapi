XPATH_STATIONS <- c(
  code = "Code",
  type = "Type",
  country = "Land",
  latitude = "Lat",
  longitude = "Lon",
  name.short = "Namen/Kort",
  name.medium = "Namen/Middel",
  name.long = "Namen/Lang"
)

get.stations <- function(...) {
  xml.data <- get.stations.xml(...)
  return( parse.stations(xml.data) )
}

download.stations <- function(...) {
  return( download( add.query(URL_STATIONS, ""), ...))
}

parse.stations <- function(xml.data) {
  return(
    as.data.frame.xml( 
      xml.data, 
      columns_xpaths = XPATH_STATIONS,  
      root_xpath = "Stations/Station"
    )
  )
}