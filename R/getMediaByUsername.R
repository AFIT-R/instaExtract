# Get Media By Username
#
# this function outputs a data frame with a user's media
# for provided username
#
#INPUTS:
# username - user who's account will be queried
# n - number of posts to pull
#
#OUTPUTS:
#
# dataframe -  n x 17 dataframe of media information.
# colnames : _typename, id, comments_disabled, geting_info,
# media_preview, thumbnail_src, thumbnail_resources, is_video,
# code, date, display_src, caption, dimensions.height, dimensions.width,
# owner.id, comments.count, likes.count



getMediaByUsername <- function(username, n = 12, maxID = ""){


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
    response <- jsonlite::fromJSON(url)

    #flattening the data down to the nodes, into a dataframe
    media <- jsonlite::flatten(response$user$media$nodes)

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
    moreAvailable <- response$user$media$page_info$has_next_page

  }

  #convert the json data to R dataframe
  return(data)

}
