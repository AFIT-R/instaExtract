# Get Media By Code
#
# filler function
#
#INPUTS:
# code - code used by instagram for a media
#
#OUTPUTS:
#
# list - with lots of stuff



getMediaByCode <- function(code){

  url <- getMediaPageLink(code)

  data <- getMediaByURL(mediaLink)

  #then uses the link in the other function
  return(data)


}
