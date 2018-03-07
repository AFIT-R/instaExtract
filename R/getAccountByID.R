#'@title Get Account By ID
#'
#'@description Gets the account information for an Instagram ID
#'
#'@param ID     An Instagram ID for a media post
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@importFrom httr GET
#'
#'@return "1705564303372666424"
#'
#'
#'@examples
#'\dontrun{ getCommentsByMediaCode("1579076894773971876", 100)}
#'

# Get Account By ID
#
# returns the account info for a given ID
#
#INPUTS:
# ID - ID of user
#
#OUTPUTS:
#
# account info for a given user


getAccountByID <- function(ID){



    #Empty data frame for rows to be addded to
    data <- data.frame()


    #create the url from Json Link
    url <- getFollowURL(ID)

    #the unflattened response
    responseURL <- httr::GET(url)$location

    #flattening the data down to the nodes, into a dataframe
    #media <- jsonlite::flatten(response)

  #convert the json data to R dataframe
  return(response)

}
