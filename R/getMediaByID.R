# Get Medias By ID
#
# filler function
#
#INPUTS:
# ID - user ID for who's account will be queried
#
#OUTPUTS:
#
# list - with a bunch of stuff



getMediaByID <- function(mediaID){

  #gets the link to the media from the ID
  mediaLink <- getLinkFromID(mediaID)

  data <- getMediaByURL(mediaLink)

  #then uses the link in the other function
  return(data)

}
