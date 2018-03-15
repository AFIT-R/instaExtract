#'@title Get Media By Username
#'
#'@description Gets the n most recent posts from a user with the given username
#'
#'@param username   An Instagram account's username
#'@param n          The number of media posts to return
#'@param maxID      Identifier to specify query location
#'@param ...   Additional options passed to a shinyAppDir
#'
#'@import dplyr
#'@importFrom plyr rbind.fill
#'@importFrom jsonlite flatten
#'
#'@return n x 17 dataframe of media information: _typename, id, \cr
#'comments_disabled, geting_info, media_preview, thumbnail_src, \cr
#'thumbnail_resources, is_video, code, date, display_src, caption, \cr
#'dimensions.height, dimensions.width, owner.id, comments.count, likes.count
#'
#'@examples
#'\dontrun{ getMediaByUsername("officialrickastley", 50)}
#'
#'@export

# Get Media By Username
#
# this function outputs a data frame with a user's media
# for provided username
#
#INPUTS:
# username - user who's account will be queried
# n - number of posts to pull
# maxID - Identifier to specify query location
#
#OUTPUTS:
#
# dataframe -  n x 17 dataframe of media information.
# colnames : _typename, id, comments_disabled, geting_info,
# media_preview, thumbnail_src, thumbnail_resources, is_video,
# code, date, display_src, caption, dimensions.height, dimensions.width,
# owner.id, comments.count, likes.count



getMediaByUsername <- function(username, n = 12, maxID = "", ...){


  #indexing variable
  i <- 0

  #boolean for checking on more data available
  moreAvailable <- TRUE

  #Empty data frame for rows to be addded to
  data <- data.frame()


  #will run while more data exists and it has not reached n results
  while(moreAvailable && i < n){

    #create the url from Json Link
    url <- getUserMediaJsonLink(username, maxID)

    #the unflattened response
    response <- getJSONFromURL(url)

    #flattening the data down to the nodes, into a dataframe
    media <- jsonlite::flatten(response$graphql$user$edge_owner_to_timeline_media$edges$node)

    #tdying list of list with no other information
    media['caption'] <- unlist(media$edge_media_to_caption.edges)

    #removes the note about global variables
    thumbnail_resources <- dplyr::quo(thumbnail_resources)
    gating_info         <- dplyr::quo(gating_info)
    gating_info.buttons <- dplyr::quo(gating_info.buttons)

    #dropping thumbnail resources and gating info since it is mostly useless and comes back as a list
    if('gating_info.buttons' %in% colnames(media)){
      media <- subset(media, select = -c(thumbnail_resources,gating_info,gating_info.buttons,edge_media_to_caption.edges))
    }
    else{
      media <- subset(media, select = -c(thumbnail_resources,gating_info,edge_media_to_caption.edges))
    }


    #iterating over the rows of the media
    for(row in 1:nrow(media)){

      #will exit loop and return data if reaching the limit
      if(i == n){
        return(data)
      }

      #will add a new row of media to data
      data <- plyr::rbind.fill(data,media[row,])

      #incrementing the counting index
      i <- i + 1

    }

    #Where to start the next query to the instagram link
    #this version just captures the id of the last node
    maxID <- media[nrow(media),]$id
    #makes sure more exists
    moreAvailable <- response$graphql$user$edge_owner_to_timeline_media$page_info$has_next_page

  }

  #convert the json data to R dataframe
  return(data)

}
