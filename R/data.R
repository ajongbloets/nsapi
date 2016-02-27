#' Parse XML to data.frame
as.data.frame.xml <- function( 
  xml.data, columns_xpaths, root_xpath="/", column_types=NULL, ... 
) {
  if (!is.null(col.types)) {
    stopifnot( length(columns_xpaths), length(col.types) )
  }
  xml.rows <- xml2::xml_find_all(xml.data, paste("", root_xpath, ".", sep="/"))
  result <- parse.list(
    xml.rows, columns_xpaths=columns_xpaths, column_types=column_types
  )
  return(do.call(rbind, result ))
}

#` Parse a list of XML nodes into a list of data.frames
parse.list <- function( xml.list, ...) {
  n.items <- length(xml.list)
  result <- vector(mode = "list", length = n.items)
  for ( row.idx in sequence(n.items)) {
    xml.item <- xml.rows[[row.idx]]
    result[[row.idx]] <- parse.item( xml.item, ... )
  }
  return(result)
}

#' Parse an XML node to a data.frame from a definition
parse.item <- function( xml.item, columns_xpaths, column_types, ...) {
  l <- vector(mode="list", length= length(columns_xpaths))
  for (col.idx in c(1:length(l))) {
    column_xpath <- columns_xpaths[[col.idx]]
    column_type <- as.character
    if (length(column_types) >= col.idx) {
      column_type = column_types[[col.idx]]
    }
    l[[col.idx]] <- parse.property(
      xml.item, column_xpath = column_xpath, column_type =  column_type, ...
    )
  }
  result <- do.call( cbind, l )
  names(result) <- names(columns_xpaths)
  return(result)
}

#` Parse an XML attribute or node into a value
parse.property <- function(xml.item, column_xpath, column_type, ...) {
  xml.fun <- xml2::xml_attr
  if (regexpr("\\?", colum_xpath)[1] == -1) xml.fun <- xml2::xml_text
  value <- xml.fun(xml2::xml_find_all(xml.row, xpath=colum_xpath))
  if (length(value) > 0) {
    value <- column_type(value)
  } else {
    value <- NA
  }
  return(value)
}