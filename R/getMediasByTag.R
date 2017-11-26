# Get Medias By Tag
#
# this function outputs a data frame translated from a json download
# from the instagram link.
#
#INPUTS:
# tag - string that will be searched on instagram
# n - number of images to look at
# maxID - identifier to specify search location
#
#OUTPUTS:
#
# dataframe -  n x 14 dataframe of media information.
# colnames : comments_disabled, id, thumbnail_src, thumbnail_resources,
# is_video, code, date, display_src, caption, dimensions.height,
# dimensions.width, owner.id, comments.count, likes.count



getMediaByTag <- function(tag, n = 20, maxID = ""){

  #create the url from the json link
  url <- paste("https://www.instagram.com/explore/tags/",tag,"/?__a=1&max_id=",maxID, sep = "")

  #download the json data
  data <- jsonlite::fromJSON(url)

  #convert the json data to R dataframe
  return(jsonlite::flatten(data$tag$media$nodes))
}
