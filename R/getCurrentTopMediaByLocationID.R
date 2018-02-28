#'@title Get Current Top Media By Location ID
#'
#'@description Gets the top 9 media posts for a location with the given location ID.
#'
#'@param ID     An Instagram ID for a location
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@import jsonlite
#'
#'@return 9x14 DF : id, thumbnail_src, thumbnail_resources, is_video, code, date, \cr
#'display_src, video_views, caption, dimensions.height, dimensions.width, \cr
#'owner.id, comments.count, likes.count
#'
#'
#'@examples
#'\dontrun{ getCurrentTopMediaByLocationID("212988663")}
#'
#'@export

# Get CurrentTopMediasByLocationId
#
# returns the TOP media for a given location ID
#
#INPUTS:
# locationID - location Id used by facebook
#
#OUTPUTS:
#
# 9x14 DF : id, thumbnail_src, thumbnail_resources, is_video, code, date
# display_src, video_views, caption, dimensions.height, dimensions.width,
#owner.id, comments.count, likes.count

#new york is 212988663

getCurrentTopMediaByLocationID <- function(locationID, ...){



  #Empty data frame for rows to be addded to
  data <- data.frame()


  #create the url from Json Link
  url <- getMediaJsonByLocationIDLink(locationID)

  #retrieve the json file from the url
  response <- getJSONFromURL(url)

  #pull desired info
  data <- jsonlite::flatten(response$location$top_posts$nodes)

  #return the converted data
  return(data)

}
