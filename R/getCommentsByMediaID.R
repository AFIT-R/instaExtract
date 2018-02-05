#'@title Get Comments By Media ID
#'
#'@description Gets the first n comments for a media with a given ID
#'
#'@param ID     An Instagram ID for a media post
#'@param n      The number of comments to return
#'@param maxID  An identifier for a comment that indicates where to start searching
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@return n x 6 dataframe - id, text, created_at, owner.id, owner.profile_pic_url, owner.username
#'
#'
#'@examples
#'\dontrun{ getCommentsByMediaID("1579076894773971876", 100)}
#'
#'@export

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



getCommentsByMediaID <- function(mediaID, n = 10, maxID = NULL, ...){

  code <- getCodeFromID(mediaID)

  data <- getCommentsByMediaCode(code)

  #convert the json data to R dataframe
  return(data)

}
