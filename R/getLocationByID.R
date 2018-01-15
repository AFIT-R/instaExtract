# Get Location By ID
#
# filler function
#
#INPUTS:
# locationID - location Id made my facebook
#
#OUTPUTS:
#
# list - with location information



getLocationByID <- function(locationID){

  #gets the link to the media from the ID
  mediaLink <- getMediaJsonByLocationIDLink(locationID)

  data <- getMediaByURL(mediaLink)

  #then uses the link in the other function
  return(data$location)

}
