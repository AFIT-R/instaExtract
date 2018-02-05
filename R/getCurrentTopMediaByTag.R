#'#'@title Get Current Top Media By Tag
#'
#'@description Gets the top 9 media posts with a given hashtag.
#'
#'@param tag    A character string representing the hashtag to be used
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@return 9x14 DF : id, shortcode, taken_at_timestamp, display_url, thumbnail_src, \cr
#'thumbnail_resources, is_video, video_view_count, edge_media_to_caption.edges, \cr
#'edge_media_to_comment.count, dimensions.height, dimensions.wdith, \cr
#'edge_liked_by.count, owner.id
#'
#'
#'@examples
#'\dontrun{ getCurrentTopMediaByTag("AirForce")}
#'
#'@export

# Get Current Top Media By Tag
#
# returns the TOP media for a given tag
#
#INPUTS:
# tag - string of tag to be searched for
#
#OUTPUTS:
#
# 9x14 DF : id, shortcode, taken_at_timestamp, display_url, thumbnail_src,
# thumbnail_resources, is_video, video_view_count, edge_media_to_caption.edges
# edge_media_to_comment.count, dimensions.height, dimensions.wdith,
# edge_liked_by.count, owner.id


getCurrentTopMediaByTag <- function(tag, ...){



  #Empty data frame for rows to be addded to
  data <- data.frame()


  #create the url from Json Link
  url <- getTagMediaJsonLink(tag,"")

  #retrieve the json file from the url
  response <- jsonlite::fromJSON(url)

  #pull desired info
  data <- jsonlite::flatten(response$graphql$hashtag$edge_hashtag_to_top_posts$edges$node)

  #return the converted data
  return(data)

}
