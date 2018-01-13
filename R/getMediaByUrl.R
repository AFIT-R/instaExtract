# Get Media By URL
#
# filler function
#
#INPUTS:
# url - direct link to the media
#
#OUTPUTS:
#
# list - with a bunch of stuff



getMediaByURL <- function(url){

  #create the url from the json link
  url <- getLinkFromURL(url)


  #download the json data
  response <- jsonlite::fromJSON(url)


  # rlist::list.flatten(response$graphql$shortcode_media
  # ldply(data.frame, flattened)
  # response$graphql$shortcode_media[1:4]

  #convert the json data to R dataframe
  return(response)

}
