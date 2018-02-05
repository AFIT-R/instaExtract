#'@title Search Tags by Tag
#'
#'@description Gets the results for hashtags returned by searching the given tag
#'
#'@param tag   A hashtag to search for
#'@param ...   Additional options passed to a shinyAppDir
#'
#'@return n x 3 dataframe where is n is the number of results: colnames : name, id, media_count
#'
#'@examples
#'\dontrun{ searchTagsByTag("Air")}
#'
#'@export

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



searchTagsByTag <- function(tag, ...){

  #create the url from the json link
  url <- getSearchJsonLink(tag)

  #download the json data
  data <- jsonlite::fromJSON(url)

  if(is.data.frame(data)){
    #convert the json data to R dataframe
    return(jsonlite::flatten(data$hashtags$hashtag))
  }

  else{
    return(data$hashtags$hashtag)
  }


}
