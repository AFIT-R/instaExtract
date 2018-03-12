#'@title Get Location by ID
#'
#'@description Returns information about a location with the given ID
#'
#'@param locationID   An Instagram ID for a location
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@return 1 x 6 dataframe - id, name, has_public_page, lat, lng, slug
#'
#'
#'@examples
#'\dontrun{ getLocationByID("212988663")}
#'
#'@export
#'
#'@importFrom jsonlite flatten

# Get Location By ID
#
# filler function
#
#INPUTS:
# locationID - location Id made my facebook
#
#OUTPUTS:
#
# 1 x 6 dataframe - ID, name, has_public_page, lat, lng, slug



getLocationByID <- function(locationID, ...){

  #gets the link to the media from the ID
  url <- getMediaJsonByLocationIDLink(locationID)

  #download the json data
  response <- getJSONFromURL(url)

  data <- response$location



  #then uses the link in the other function
  return(data.frame(data[1:6]))

}
