# Get Comments By Media ID
#
# returns the first n comments for a media with given ID
#
#INPUTS:
# mediaID - ID of the media
# n = number of comments to grab
# maxID - the the space to start looking default Null
#
#OUTPUTS:
#
# n x 6 dataframe - id, text, created_at, owner.id, owner.profile_pic_url,
# owner.username



getCommentsByMediaID <- function(mediaID, n = 10, maxID = NULL){

  code <- getCodeFromID(mediaID)

  data <- getCommentsByMediaCode(code)

  #convert the json data to R dataframe
  return(data)

}
