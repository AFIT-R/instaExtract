#'@title Get Likes By Media ID
#'
#'@description Gets the first n likes for a media with a given Instagram shortcode
#'
#'@param ID     An Instagram ID for a media post
#'@param n      The number of comments to return
#'@param maxID  An identifier for a comment that indicates where to start searching
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@return n x 7 dataframe - id, username,full_name,profile_pic_url, \cr
#'is_verified_followed_by_viewer,requested_by_viewer
#'
#'
#'@examples
#'\dontrun{ getLikesByMediaID("1579076894773971876", 100)}
#'
#'@export

# Get Likes By Media Code
#
# returns the first n usernames for the likes on a  media with given Code
#
#INPUTS:
# ID - code of the media
# n = number of likes to grab
# maxID - the the space to start looking default Null
#
#OUTPUTS:
#
# n x 7 dataframe - id, username,full_name,profile_pic_url,
# is_verified_followed_by_viewer,requested_by_viewer

getLikesByMediaID <- function(ID, n = 10, maxID = "", ...){

  code <- getCodeFromID(ID)

  data <- getLikesByMediaCode(code)

  #convert the json data to R dataframe
  return(data)

}
