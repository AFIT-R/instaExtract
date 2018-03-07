#'@title Get Media By Tag
#'
#'@description Gets the n most recent posts with the given hashtag
#'
#'@param tag   A hashtag
#'@param n     The number of media posts to return
#'@param maxID Identifier to specify query location
#'@param ...   Additional options passed to a shinyAppDir
#'
#'@importFrom jsonlite flatten
#'@importFrom plyr rbind.fill
#'
#'@return n x 15 dataframe: comments_disabled, id, thumbnail_src, thumbnail_resources, is_video, \cr
#'code, date, display_src, video_views, caption, dimension.height, \cr
#'dimensions.width, owner.id, comments.count, likes.count
#'
#'@examples
#'\dontrun{ getMediaByTag("Batman", 50)}
#'
#'@export

# Get Medias By Tag
#
# this function outputs a data frame translated from a json download
# from the instagram link.
#
#INPUTS:
# tag - string that will be searched on instagram
# n - number of images to look at
# maxID - identifier to specify search location
#
#OUTPUTS:
#
# dataframe -  n x 15 dataframe of media information.
# colnames : comments_disabled, id, thumbnail_src, thumbnail_resources,
# is_video, code, date, display_src, video_views, caption, dimensions.height,
# dimensions.width, owner.id, comments.count, likes.count



getMediaByTag <- function(tag, n = 20, maxID = "", ...){


  #indexing variable
  i <- 0

  #boolean for checking on more data available
  moreAvailable <- TRUE

  #Empty data frame for rows to be addded to
  data <- data.frame()


  #will run while more data exists and it has not reached n results
  while(moreAvailable && (i < n)){

    #create the url from Json Link
    url <- getTagMediaJsonLink(tag,maxID)

    #the unflattened response
    response <- getJSONFromURL(url)

    #will return as list if there is only one result
    if(!is.data.frame(response$graphql$hashtag$edge_hashtag_to_media$edges$node)){
      return(response$graphql$hashtag$edge_hashtag_to_media$edges$node)
    }

    else{
      #flattening the data down to the nodes, into a dataframe
      media <- jsonlite::flatten(response$graphql$hashtag$edge_hashtag_to_media$edges$node)

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
      maxID <- response$graphql$hashtag$edge_hashtag_to_media$page_info$end_cursor
      #makes sure more exists
      moreAvailable <- response$graphql$hashtag$edge_hashtag_to_media$page_info$has_next_page

    }
  }

  #convert the json data to R dataframe
  return(data)
}
