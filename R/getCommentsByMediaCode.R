#'@title Get Comments By Media Code
#'
#'@description Gets the first n comments for a media with a given Instagram shortcode
#'
#'@param code   An Instagram shortcode for a media post
#'@param n      The number of comments to return
#'@param maxID  An identifier for a comment that indicates where to start searching
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@importFrom jsonlite flatten
#'@importFrom plyr rbind.fill
#'
#'@return n x 6 dataframe - id, text, created_at, owner.id, owner.profile_pic_url, owner.username
#'
#'
#'@examples
#'\dontrun{ getCommentsByMediaCode("W0IL2cujb3", 100)}
#'
#'@export

# Get Comments By Media Code
#
# returns the first n comments for a media with given Code
#
#INPUTS:
# code - code of the media
# n = number of comments to grab
# maxID - the the space to start looking default Null
#
#OUTPUTS:
#
# n x 6 dataframe - id, text, created_at, owner.id, owner.profile_pic_url,
# owner.username


getCommentsByMediaCode <- function(code, n = 10, maxID = "", ...){


  MAX_COMMENTS_PER_REQUEST <- 300


  #indexing variable
  i <- 0

  #remaining number of comments
  remain <- n

  #boolean for checking on more data available
  moreAvailable <- TRUE

  #Empty data frame for rows to be addded to
  data <- data.frame()


  #will run while more data exists and it has not reached n results
  while(moreAvailable && i < n){

    if(remain > MAX_COMMENTS_PER_REQUEST){
      numberOfCommentsToRetrieve <- MAX_COMMENTS_PER_REQUEST
      remain <- remain - MAX_COMMENTS_PER_REQUEST
    }
    else{
      numberOfCommentsToRetrieve <- remain
      remain <- 0
    }



    #create the url from Json Link
    url <- getCommentsByCodeLink(code, numberOfCommentsToRetrieve, maxID)

    #the unflattened response
    response <- getJSONFromURL(url)

    if(!is.data.frame(response$data$shortcode_media$edge_media_to_comment$edges$node)){
      stop("No comments")
    }

    #flattening the data down to the nodes, into a dataframe
    media <- jsonlite::flatten(response$data$shortcode_media$edge_media_to_comment$edges$node)

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
    maxID <- media[nrow(media),]$node$id

    #makes sure more exists
    moreAvailable <- response$data$shortcode_media$edge_media_to_comment$page_info$has_next_page
    numberOfComments <- response$data$shortcode_media$edge_media_to_comment$count

    if(n > numberOfComments){
      n = numberOfComments
    }

  }

  #convert the json data to R dataframe
  return(data)

}
