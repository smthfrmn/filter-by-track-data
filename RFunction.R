library('move')

rFunction <- function(data,variab,other=NULL,rel,valu,time=FALSE)
{
  Sys.setenv(tz="GMT")
  
  if (is.null(variab) | is.null(rel) | is.null(valu)) logger.info("One of your parameters has not been set. This will lead to an error.")
  
  N <- dim(idData(data))[1]
  if (variab=="other") variab <- other
  
  if (variab %in% names(idData(data)))
  {
    if (rel=="%in%") #works for numeric or character values
    {
      valus <- strsplit(as.character(valu),",")[[1]]
      
      if (any(idData(data)[,variab] %in% valus))
      {
        data.sub <- data[[idData(data)[,variab] %in% valus]] ## help by Kami to subset moveStack directly
        result <- data.sub
        logger.info(paste(dim(idData(data.sub))[1]," (of",N,") individuals fulfill your required property:",variab," ",rel," [",valu,"]."))
        logger.info(paste(length(data.sub),"locations of your data (containing originally",length(data),"locations) have been selected."))
      } else 
      {
        result <- NULL
        logger.info("None of your data fulfill the required property. Go back and reconfigure the App. Now it is returning NULL, probably leading to error.")
      }  
    } else
    {
      if (time==TRUE) fullrel <- eval(parse(text=paste0("as.POSIXct(idData(data)$",variab,") ",rel," as.POSIXct('",valu,"')"))) else fullrel <- eval(parse(text=paste0("idData(data)$",variab," ",rel," ",valu)))
      if (any(fullrel))
      {
        data.sub <- data[[fullrel]]
        result <- data.sub
        logger.info(paste(dim(idData(data.sub))[1]," (of",N,") individuals fulfill your required property:",variab," ",rel," [",valu,"]."))
        logger.info(paste(length(data.sub),"locations of your data (containing originally",length(data),"locations) have been selected."))
      } else 
      {
        result <- NULL
        logger.info("None of your data fulfill the required property. Go back and reconfigure the App. Now it is returning NULL, probably leading to error.")
        
      }
    }
  } else
  {
    result <- NULL
    logger.info("You selected id Variable is not available in the data set. Go back and reconfigure the App. Now it is returning NULL, probably leading to error.")
  }
  
  return(result)
}

  
  
  
  
  
  
  
  
  
  
