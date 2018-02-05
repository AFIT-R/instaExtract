#'@title Get Media By Location Mapping
#'
#'@description Gets the n most recent media posts for all locations in  a location mapping
#'
#'@param mapping  A location mapping following the format of createLocationMapping()
#'@param n        The number of results to retrieve for each location
#'@param maxID    Identifier to specify query location
#'@param ...      Additional options passed to a shinyAppDir
#'
#'@return  (n*m) x 15 dataframe where m is the number of locations in mapping: \cr
#' comments_disabled, id, thumbnail_src, thumbnail_resources, is_video, \cr
#'code, date, display_src, video_views, caption, dimension.height, \cr
#'dimensions.width, owner.id, comments.count, likes.count
#'
#'
#'@examples
#'\dontrun
#'{
#'mapping <- createLocationMapping("United States", "New York")
#'
#'getMediaByLocationMapping(mapping)
#'}
#'
#'@export

# Get Media By Location Mapping
#
# Gets the n most recent media posts for all locations in  a location mapping
#
#INPUTS:
#mapping  A location mapping following the format of createLocationMapping()
#n        The number of results to retrieve for each location
#maxID    Identifier to specify query location

#OUTPUTS:
#
# (n*m) x 15 dataframe where m is the number of locations in mapping:
# comments_disabled, id, thumbnail_src, thumbnail_resources, is_video,
# code, date, display_src, video_views, caption, dimension.height,
# dimensions.width, owner.id, comments.count, likes.count

getMediaByLocationMapping <- function(mapping, n = 12, ...){

  #the dataframe that will eventually be returned
  full_data <- data.frame()

  #status updater to user
  print(paste("Total Locations: ", nrow(mapping)))
  percent <- 0
  time <- Sys.time()

  #for loop iterating over locations in mapping
  for(row in 1:nrow(mapping)){


    #status updating for user
    if(row/nrow(mapping) > percent+.01){

      percent <- row/nrow(mapping)
      print(paste("Progress: ",round(percent * 100,2), "%", sep = ""))

      print(paste("Est Time Left: ",round((Sys.time() - time)*(100 - percent*100),3), "seconds", sep = ""))
      time <- Sys.time()
    }

    #Call n most recent media posts for each location in mapping
    location_media <- getMediaByLocationID(mapping[row,1], n)

    #as long as something is returned
    if(!is.null(location_media)){

      #add it to the full_data dataframe
      full_data <- plyr::rbind.fill(full_data, location_media )

    }
  }

  #return media for all locations
  return(full_data)

}
