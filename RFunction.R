library("move2")
library("lubridate")
library("stringr")
library("rapportools")

rFunction <- function(data, variab, other = NULL, rel, valu, time = FALSE) {

  result <- NULL
  variab <- if (variab != 'other') trimws(variab) else trimws(other)
  valu <- trimws(valu)
  
  # validation of input settings
  empty_settings <- rapportools::is.empty(variab) | rapportools::is.empty(rel) | rapportools::is.empty(valu)
  if (empty_settings) {
    logger.error("One of your required settings is empty, please check that you have filled out all required settings.")
    return(result)
  }
  
  track_attribute_fields <- names(move2::mt_track_data(data))

  if (!variab %in% track_attribute_fields) {
    logger.error("You selected a field to filter by that is not available in the your track attributes data. Go back to the app settings and select a valid field.")
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
    logger.info(
      stringr::str_interp("Filtering using parameters field '${variab}', operator '${rel}', and value '${valu}' returned no data.")
    )
  }


  return(result)
}
