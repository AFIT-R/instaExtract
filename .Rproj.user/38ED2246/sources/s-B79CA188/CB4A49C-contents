# Get Medias By Username
#
# this function outputs a data frame with a user's media
# for provided username
#
#INPUTS:
# username - user who's account will be queried
#
#OUTPUTS:
#
# dataframe -  n x 17 dataframe of media information.
# colnames : _typename, id, comments_disabled, geting_info,
# media_preview, thumbnail_src, thumbnail_resources, is_video,
# code, date, display_src, caption, dimensions.height, dimensions.width,
# owner.id, comments.count, likes.count



getMediasByUsername <- function(username, n = 12, maxID = ""){

  #retrieve the url for the json link
  url <- getUserMediaJsonLink(username, maxID)

  #download the json data
  data <- jsonlite::fromJSON(url)

  #convert the json data to R dataframe
  return(jsonlite::flatten(data$user$media$nodes))

}
