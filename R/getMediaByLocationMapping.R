#'@title Get Media By Location Mapping
#'
#'@description Gets the n most recent media posts for all locations in  a location mapping
#'
#'@param mapping  A location mapping following the format of createLocationMapping()
#'@param n        The number of results to retrieve for each location
#'@param ...      Additional options passed to a shinyAppDir
#'
#'@importFrom lubridate seconds_to_period
#'@importFrom plyr rbind.fill
#'
#'@return  (n*m) x 17 dataframe where m is the number of locations in mapping: \cr
#' comments_disabled, id, thumbnail_src, is_video, code, date, display_src, \cr
#' video_views, caption, dimension.height, dimensions.width, \cr
#' edge_media_preview_like.count, owner.id, comments.count, \cr
#'likes.count, location_name, location_id
#'
#'
#'@examples
#'\dontrun{
#'smapping <- createLocationMapping("United States", "New York")
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
# (n*m) x 17 dataframe where m is the number of locations in mapping:
# comments_disabled, id, thumbnail_src, is_video,
# code, date, display_src, video_views, caption, dimension.height,
# dimensions.width, edge_media_preview_like.count, owner.id, comments.count,
# likes.count, location_name, location_id

getMediaByLocationMapping <- function(mapping, n = 12, ...){

  #the dataframe that will eventually be returned
  full_data <- data.frame()

  #status updater to user
  print(paste("Total Locations: ", nrow(mapping)))
  percent <- 0
  average <- 0
  last_row <- 0
  time <- Sys.time()

  #for loop iterating over locations in mapping
  for(row in 1:nrow(mapping)){


    #status updating for user
    if(row/nrow(mapping) >= percent+.01){

      percent <- row/nrow(mapping)
      print(paste("Progress: ",round(percent * 100,2), "%", sep = ""))


      difference <- difftime(Sys.time(),time , units = 'secs')

      average <- (average*(last_row) + difference*(row-last_row))/(row)
      last_row <- row

      print(paste("Est Time Left: ", ((average)*(100 - percent*100)) %>%
                    lubridate::seconds_to_period() %>%
                    round(0), sep = ""))
      time <- Sys.time()
    }

    #Call n most recent media posts for each location in mapping
    location_media <- getMediaByLocationID(mapping[row, 'id'], n)

    #dropping thumbnail resources since it is mostly useless and comes back as a list
    location_media <- subset(location_media, select = -thumbnail_resources)

    #add the location name and id for use later
    for(row in 1:nrow(location_media)){
      location_media[row,'location_name'] <- mapping[row, 'name']
      location_media[row,'location_id'] <- mapping[row, 'id']

    }

    #as long as something is returned
    if(!is.null(location_media)){

      #add it to the full_data dataframe
      full_data <- plyr::rbind.fill(full_data, location_media )
    }
  }

  #return media for all locations
  return(full_data)

}
