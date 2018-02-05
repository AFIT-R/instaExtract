#'@title Get Media By Url
#'
#'@description Gets information for a media post with given media URL
#'
#'@param url    The Instagram url for the media
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@return 1 x 42 dataframe: X__typename, id, shortcode, dimensions.height, dimensions.width, \cr
#'media_preview, display_url, display_resources.src1, display_resources.src2, display_resources.src3, \cr
#'display_resources.config_width1, display_resources.config_width2, display_resources.config_width3, \cr
#'display_resources.config_height1, display_resources.config_height2, display_resources.config_height3, \cr
#'is_video, should_log_client_event, tracking_token, edge_media_to_caption.edges.node.text, \cr
#'caption_is_edited, comments_disabled, taken_at_timestamp, location.id, location.has_public_page, \cr
#'location.name, location.slug, viewer_has_liked, viewer_has_saved, viewer_has_saved_to_collection, \cr
#'owner.id, owner.profile_pic_url, owner.username, owner.blocked_by_viewer, owner.followed_by_viewer, \cr
#'owner.full_name, owner.has_blocked_viewer, owner.is_private, owner.is_unpublished, owner.is_verified, \cr
#'owner.requested_by_viewer, is_ad
#'
#'
#'@examples
#'\dontrun{getMediaByURL("https://www.instagram.com/p/BeqeY3aB2Qt/")}
#'
#'@export


# Get Media By URL
#
# filler function
#
#INPUTS:
# url - direct link to the media
#
#OUTPUTS:
#
# 1 x 42 dataframe: "X__typename"                           "id"
# [3] "shortcode"                             "dimensions.height"
# [5] "dimensions.width"                      "media_preview"
# [7] "display_url"                           "display_resources.src1"
# [9] "display_resources.src2"                "display_resources.src3"
# [11] "display_resources.config_width1"       "display_resources.config_width2"
# [13] "display_resources.config_width3"       "display_resources.config_height1"
# [15] "display_resources.config_height2"      "display_resources.config_height3"
# [17] "is_video"                              "should_log_client_event"
# [19] "tracking_token"                        "edge_media_to_caption.edges.node.text"
# [21] "caption_is_edited"                     "comments_disabled"
# [23] "taken_at_timestamp"                    "location.id"
# [25] "location.has_public_page"              "location.name"
# [27] "location.slug"                         "viewer_has_liked"
# [29] "viewer_has_saved"                      "viewer_has_saved_to_collection"
# [31] "owner.id"                              "owner.profile_pic_url"
# [33] "owner.username"                        "owner.blocked_by_viewer"
# [35] "owner.followed_by_viewer"              "owner.full_name"
# [37] "owner.has_blocked_viewer"              "owner.is_private"
# [39] "owner.is_unpublished"                  "owner.is_verified"
# [41] "owner.requested_by_viewer"             "is_ad"



getMediaByURL <- function(url, ...){

  #create the url from the json link
  url <- getLinkFromURL(url)

  #download the json data
  response <- jsonlite::fromJSON(url)

  #the response narrowed to information
  response <- response$graphql$shortcode_media

  #down to the comments
  first <- response[1:14]
  #down to the likes
  second <- response[16:17]
  #the rest
  third <- response[19:25]

  #unlists the lists, makes dataframes, flips them, and makes them frames again
  firstdf <- data.frame(unlist(first)) %>% t() %>% data.frame()
  seconddf <- data.frame(unlist(second)) %>% t() %>% data.frame()
  thirddf <- data.frame(unlist(third)) %>% t() %>% data.frame()

  #combine dataframes
  data <- cbind(firstdf, seconddf, thirddf)

  #return the dataframe
  return(data)

}
