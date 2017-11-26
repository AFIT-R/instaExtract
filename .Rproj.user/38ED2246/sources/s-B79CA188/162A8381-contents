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



searchAccountsByUsername <- function(username){

  #create the url from the json link
  url <- paste("https://www.instagram.com/web/search/topsearch/?query=",username, sep = "")

  #download the json data
  data <- jsonlite::fromJSON(url)

  #convert the json data to R dataframe
  return(jsonlite::flatten(data$users$user))

}
