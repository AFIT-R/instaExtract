# Search Tags By Tag
#
# this function outputs a data frame with search results
# for provided tag
#
#INPUTS:
# tag - string that will be searched on instagram
#
#OUTPUTS:
#
# dataframe -  n x 3 dataframe of media information.
# colnames : name, id, media_count



searchTagsByTag <- function(tag){

  #create the url from the json link
  url <- paste("https://www.instagram.com/web/search/topsearch/?query=",tag, sep = "")

  #download the json data
  data <- jsonlite::fromJSON(url)

  #convert the json data to R dataframe
  return(jsonlite::flatten(data$hashtags$hashtag))

}
