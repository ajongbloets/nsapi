#
#
as.data.frame.xml <- function( xml.data, columns_xpaths, root_xpath="/", col.types=NULL, ... ) {
  if (!is.null(col.types)) stopifnot( length(columns_xpaths), length(col.types) )
  xml.rows <- xml2::xml_find_all(xml.data, paste("", root_xpath, ".", sep="/") )
  result <- vector(mode = "list", length = length(xml.rows))
  ## we do this per item, so first get all items
  for( row.idx in sequence(length(xml.rows)) ) {
    xml.row <- xml.rows[[row.idx]]
    l <- vector(mode="list", length= length(columns_xpaths))
    for (col.idx in c(1:length(l))) {
      colum_xpath <- columns_xpaths[[col.idx]]
      xml.fun <- xml2::xml_attr
      if (regexpr("\\?", colum_xpath)[1] == -1) xml.fun <- xml2::xml_text
      col.type <- ifelse(is.null(col.types), as.character, col.types[[col.idx]])
      node <- xml.fun(xml2::xml_find_all(xml.row, xpath=colum_xpath))
      l[[col.idx]] <- data.frame(ifelse(length(node) > 0, col.type(node), NA), stringsAsFactors=F)
    }
    result[[row.idx]] <- do.call( cbind, l )
    names(result[[row.idx]]) <- names(columns_xpaths)
  }
  df <- do.call(rbind, result )
  return(df)
}