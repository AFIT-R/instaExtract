#'@title Get Current Top Media By Location ID
#'
#'@description Gets the top 9 media posts for a location with the given location ID.
#'
#'@param mapping  A location mapping following the format of createLocationMapping()
#'@param ...      Additional options passed to a shinyAppDir
#'
#'@importFrom plyr rbind.fill
#'
#'@return (9*n)x14 DF where n is the number of locations in mapping: \cr
#'id, thumbnail_src, thumbnail_resources, is_video, code, date, \cr
#'display_src, video_views, caption, dimensions.height, dimensions.width, \cr
#'owner.id, comments.count, likes.count
#'
#'
#'@examples
#'\dontrun{
#'mapping <- createLocationMapping("United States", "New York")
#'getCurrentTopMediaByLocationMapping(mapping)
#'}
#'
#'@export

# Get CurrentTopMediasByLocationMapping
#
# returns the TOP media for all locations in a given location mapping
#
#INPUTS:
# mapping- A location mapping following the format of createLocationMapping()
#
#OUTPUTS:
#
# (9*n)x14 DF : id, thumbnail_src, thumbnail_resources, is_video, code, date
# display_src, video_views, caption, dimensions.height, dimensions.width,
#owner.id, comments.count, likes.count


getCurrentTopMediaByLocationMapping <- function(mapping, ...){

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
      print(paste("Progress: ",percent * 100, "%", sep = ""))

      print(paste("Est Time Left: ",(Sys.time() - time)*(100 - percent*100), "seconds", sep = ""))
      time <- Sys.time()
    }

    #Call top media by location for each location in mapping
    location_media <- getCurrentTopMediaByLocationID(mapping[row,1])

    #as long as something is returned
    if(!is.null(location_media)){
      #add it to the full_data dataframe
      full_data <- plyr::rbind.fill(full_data, location_media )

    }
  }

  #return media for all locations
  return(full_data)

}
