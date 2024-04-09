library("move2")
library("lubridate")
library("stringr")
library("rapportools")

rFunction <- function(data, variab, other = NULL, rel, valu, time = FALSE) {
  result <- NULL
  
  # validate input settings
  variab <- if (variab != "other") trimws(variab) else trimws(other)
  valu <- trimws(valu)

  empty_settings <- rapportools::is.empty(variab) | rapportools::is.empty(rel) | rapportools::is.empty(valu)
  if (empty_settings) {
    logger.error("One of your required settings is empty, please check that you have filled out all required settings.")
    return(result)
  }

  if (rel == "contains" & isTRUE(time)) {
    logger.error("Relation 'contains' is not supported for time fields, please pick a different relation to filter by.")
    return(result)
  }
  
  track_attribute_fields <- names(move2::mt_track_data(data))

  if (!variab %in% track_attribute_fields) {
    logger.error("You selected a field to filter by that is not available in your track attributes data. Go back to the app settings and select a valid field.")
    return(result)
  }

  # begin actual filtering
  
  # handle vector versus string value
  value_split <- if(rel == "%in%" | rel == "contains") strsplit(as.character(valu), ",")[[1]] else str_interp("'${valu}'")
  
  # handle value if time
  value_str <- if(isTRUE(time)) stringr::str_interp("as.POSIXct(${value_split}, tz = 'UTC')") else value_split
  
  # handle variab if time
  variab_str <- if(isTRUE(time)) stringr::str_interp("as.POSIXct(${variab}, tz = 'UTC')") else variab

  if (rel == "contains") {
    filter_str <- stringr::str_interp(
      "stringr::str_detect(${variab_str}, '${paste(value_str, collapse = '|')}')")
  } else {
    filter_str <- stringr::str_interp("${variab_str} ${rel} ${value_str}")
  }

  logger.debug(
    stringr::str_interp("Filtering with query: ${filter_str}")
  )

  result <- tryCatch(
    {
      result <- data |>
        move2::filter_track_data(
          !!rlang::parse_expr(filter_str)
        )
    },
    error = function(cond) {
      logger.error(
        stringr::str_interp("Error filtering data, check that your settings are valid: ${conditionMessage(cond)}")
      )
    },
    warning = function(cond) {
      logger.warn(
        stringr::str_interp("Warning encountered while filtering data, result may be incorrect: ${conditionMessage(cond)}")
      )
    }
  )

  if (is.null(result)) {
    # if encountered error during filter
    return(result)
  }

  total_tracks <- nrow(data)
  if (nrow(result) != 0) {
    logger.info(
      stringr::str_interp("Filtered ${nrow(result)} of ${nrow(data)} rows, using parameters: field '${variab}', operator '${rel}', and value '${valu}'.")
    )
  } else {
    logger.warn(
      stringr::str_interp("Filtered ${nrow(result)} of ${nrow(data)} rows, using parameters: field '${variab}', operator '${rel}', and value '${valu}'.")
    )
  }


  return(result)
}
