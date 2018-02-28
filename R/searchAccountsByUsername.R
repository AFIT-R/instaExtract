#'@title Search Accounts By Username
#'
#'@description Gets the results for accounts returned by searching the given username
#'
#'@param username   A username to search for
#'@param ...   Additional options passed to a shinyAppDir
#'
#'@import jsonlite
#'
#'@return nx11 dataframe where n is number returned: pk (owner.id), username, full_name, \cr
#'is_private, profile_pic_url, profile_pic_id, is_verified, has_anonymous_profile_picture, \cr
#'ollower_count, byline, mutual_followers_count
#'
#'@examples
#'\dontrun{ searchAccountsByUsername("AirForce")}
#'
#'@export

# Search Accounts by Username
#
# this function outputs a data frame with search results
# for provided username
#
#INPUTS:
# username - string that will be searched on instagram
#
#OUTPUTS:
#
# dataframe -  n x 11 dataframe of media information.
# colnames : pk (owner.id), username, full_name,
# is_private, profile_pic_url, profile_pic_id, is_verified,
# has_anonymous_profile_picture, follower_count, byline,
# mutual_followers_count



searchAccountsByUsername <- function(username, ...){

  #create the url from the json link
  url <- getSearchJsonLink(username)

  #download the json data
  data <- getJSONFromURL(url)

  #convert the json data to R dataframe
  return(jsonlite::flatten(data$users$user))

}
