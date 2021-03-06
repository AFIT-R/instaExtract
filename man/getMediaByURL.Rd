% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getMediaByURL.R
\name{getMediaByURL}
\alias{getMediaByURL}
\title{Get Media By Url}
\usage{
getMediaByURL(url, ...)
}
\arguments{
\item{url}{The Instagram url for the media}

\item{...}{Additional options passed to a shinyAppDir}
}
\value{
1 x 42 dataframe: X__typename, id, shortcode, dimensions.height, dimensions.width, \cr
media_preview, display_url, display_resources.src1, display_resources.src2, display_resources.src3, \cr
display_resources.config_width1, display_resources.config_width2, display_resources.config_width3, \cr
display_resources.config_height1, display_resources.config_height2, display_resources.config_height3, \cr
is_video, should_log_client_event, tracking_token, edge_media_to_caption.edges.node.text, \cr
caption_is_edited, comments_disabled, taken_at_timestamp, location.id, location.has_public_page, \cr
location.name, location.slug, viewer_has_liked, viewer_has_saved, viewer_has_saved_to_collection, \cr
owner.id, owner.profile_pic_url, owner.username, owner.blocked_by_viewer, owner.followed_by_viewer, \cr
owner.full_name, owner.has_blocked_viewer, owner.is_private, owner.is_unpublished, owner.is_verified, \cr
owner.requested_by_viewer, is_ad
}
\description{
Gets information for a media post with given media URL
}
\examples{
\dontrun{getMediaByURL("https://www.instagram.com/p/BeqeY3aB2Qt/")}

}
