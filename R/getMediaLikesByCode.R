# Get Media Likes By Code
#
# returns the first n usernames for the likes on a  media with given Code
#
#INPUTS:
# code - code of the media
# n = number of likes to grab
# maxID - the the space to start looking default Null
#
#OUTPUTS:
#
# n x 7 dataframe - id, username,full_name,profile_pic_url,
# is_verified_followed_by_viewer,requested_by_viewer

MAX_LIKES_PER_REQUEST <- 300


getMediaLikesByCode <- function(code, n = 10, maxID = ""){


  #indexing variable
  i <- 0

  #remaining number of likes
  remain <- n

  #boolean for checking on more data available
  moreAvailable <- TRUE

  #Empty data frame for rows to be addded to
  data <- data.frame()


  #will run while more data exists and it has not reached n results
  while(moreAvailable && i < n){

    if(remain > MAX_LIKES_PER_REQUEST){
      number_of_likes_to_retrieve <- MAX_LIKES_PER_REQUEST
      remain <- remain - MAX_LIKES_PER_REQUEST
    }
    else{
      number_of_likes_to_retrieve <- remain
      remain <- 0
    }



    #create the url from Json Link
    url <- getLastLikesByShortcodeLink(code, number_of_likes_to_retrieve, maxID)

    #the unflattened response
    response <- jsonlite::fromJSON(url)

    #flattening the data down to the nodes, into a dataframe
    media <- jsonlite::flatten(response$data$shortcode_media$edge_liked_by$edges$node)

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
    more_available <- response$data$shortcode_media$edge_liked_by$page_info$has_next_page
    number_of_likes <- response$data$shortcode_media$edge_liked_by$count

    if(n > number_of_likes){
      n = number_of_likes
    }

  }

  #convert the json data to R dataframe
  return(data)

}
