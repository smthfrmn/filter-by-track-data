library("move2")
library("lubridate")
library("stringr")


# TODO:
# - Add validation for <,> for factors
rFunction <- function(data, variab, other = NULL, rel, valu, time = FALSE) {
  
  browser()
  result <- NULL
  valu <- trimws(valu)
  if (is.null(variab) | is.null(rel) | (is.null(valu) | valu == "")) {
    logger.error("One of your parameters has not been set. This will lead to an error.")
    return(result)
  }

  track_attribute_fields <- names(move2::mt_track_data(data))

  # if pre-defined variab selected update attribute names (and replace "_" with ".")
  # else keep with user-provided other
  # if (variab == "other") {
  #   variab <- other
  # } else {
  #   names(move2::mt_track_data(data)) <- make.names(track_attribute_fields, allow_ = FALSE)
  # }

  # standardize specific fields from front-end
  if (variab == "local_identifier" & 
      "individual_local_identifier" %in% track_attribute_fields
      ) variab <- "individual_local_identifier"
  
  if (variab == "taxon_canonical_name" &
      "individual_taxon_canonical_name" %in% track_attribute_fields
      ) variab <- "individual_taxon_canonical_name"

  if (!variab %in% track_attribute_fields) {
    logger.error("You selected a field to filter by that is not available in the your reference data set. Go back to the app settings and select a valid field.")
    return(result)
  }

  
  # begin actual filtering
  value_str <- valu

  if (rel == "%in%") {
    value_str <- strsplit(as.character(valu), ",")[[1]]
  }

  if (isTRUE(time)) {
    filter_str <- stringr::str_interp("as.POSIXct(${variab}, tz = 'UTC') ${rel} as.POSIXct('${value_str}', tz = 'UTC')")
  } else {
    filter_str <- stringr::str_interp("${variab} ${rel} ${value_str}")
  }

  result <- data |>
    move2::filter_track_data(
      !!rlang::parse_expr(filter_str)
    )

  total_tracks <- nrow(data)
  if (nrow(result) != 0) {
    logger.info(
      stringr::str_interp("Filtered ${nrow(result)} of ${nrow(data)} rows, using parameters: field '${variab}', operator '${rel}', and value '${valu}'.")
    )
  } else {
    logger.info("Filtering using parameters field '${variab}', operator '${rel}', and value '${valu}' returned no data.")
  }


  return(result)
}
