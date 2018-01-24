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
