###############################
#####  Session Info ###########
###############################

generateHeaders <- function(){

  headers <- ""

  return <- headers
}




###############################
#####  JSON LINKS #############
###############################

User_Media_Json_Link <- "https://www.instagram.com/{username}/?__a=1&max_id={maxID}"
Tag_Media_Json_Link <- "https://www.instagram.com/explore/tags/{tag}/?__a=1&max_id={maxID}"
Search_Json_Link <- "https://www.instagram.com/web/search/topsearch/?query={query}"
#MediaByID_Json_Link <-
Media_Link <- "https://www.instagram.com/p/{code}"
Media_URL_Link <- "{url}/?__a=1"
Comments_Code_Link <- "https://www.instagram.com/graphql/query/?query_id=17852405266163336&shortcode={{shortcode}}&first={{count}}&after={{commentId}}"
Last_Likes_Shortcode_Link <-'https://www.instagram.com/graphql/query/?query_id=17864450716183058&variables={"shortcode":"{{shortcode}}","first":{{count}},"after":"{{likeId}}"}'
Follow_URL <- "https://www.instagram.com/web/friendships/{{accountId}}/follow/"
MEDIA_JSON_BY_LOCATION_ID <- 'https://www.instagram.com/explore/locations/{{facebookLocationId}}/?__a=1&max_id={{maxId}}'
LOCATION_EXPLORE_LINK <- "https://www.instagram.com/explore/locations{{countryID}}{{countrySlug}}/?__a=1&page={{pageID}}"


##########################
### Default Url Grab  ####
##########################
#'@importFrom jsonlite fromJSON
getJSONFromURL <- function(url){

  response <- tryCatch(jsonlite::fromJSON(url),
                       error= function(err){
                         #the error when the json file isn't correct
                         if( attr(err,'class')[1] == 'simpleError'){
                           cat(paste("URL used does not return a JSON File or link doesn't work.  JSONLite returned:\n", err))
                         }
                       }
                       )
  return(response)
}






##########################
### LINK CONSTRUCTION ####
##########################
getUserMediaJsonLink <- function(user, maxID){

  link <- User_Media_Json_Link
  link <- gsub("{username}", user, link, fixed = TRUE)
  link <- gsub("{maxID}", maxID, link, fixed = TRUE)

  return(link)

}

getTagMediaJsonLink <- function(tag, maxID){

  link <- Tag_Media_Json_Link
  link <- gsub("{tag}", tag, link, fixed = TRUE)
  link <- gsub("{maxID}", maxID, link, fixed = TRUE)

  return(link)

}

getSearchJsonLink <- function(query){

  link <- Search_Json_Link
  link <- gsub("{query}", query, link, fixed = TRUE)

  return(link)

}


# getMediaByIDJsonLink <- function(query){
#
#   link <- MediaByID_Json_Link
#   link <- gsub("{query}", query, link, fixed = TRUE)
#
#   return(link)
#
# }

getMediaPageLink <- function(code){

  link <- Media_Link
  link <- gsub("{code}", code, link, fixed = TRUE)

  return(link)
}

getLinkFromURL <- function(url){

  link <- Media_URL_Link

  #if the final "/" is included, ovewrite it to avoid double slash
  if(substr(url, nchar(url)-1, nchar(url)) == "/"){
    link <- gsub("{url}/", url, link, fixed = TRUE)
  }
  else{
    link <- gsub("{url}", url, link, fixed = TRUE)
  }


  return(link)

}

getCommentsByCodeLink <- function(code, count, maxID){


  link <- Comments_Code_Link
  link <- gsub("{{shortcode}}", code, link, fixed = TRUE)
  link <- gsub("{{count}}", count, link, fixed = TRUE)
  link <- gsub("{{commentId}}", maxID, link, fixed = TRUE)

  return(link)
}

getLastLikesByShortcodeLink <- function(code, count, maxID){


  link <- Last_Likes_Shortcode_Link
  link <- gsub("{{shortcode}}", code, link, fixed = TRUE)
  link <- gsub("{{count}}", count, link, fixed = TRUE)
  link <- gsub("{{likeId}}", maxID, link, fixed = TRUE)

  return(link)
}

getFollowURL <- function(ID){

  link <- Follow_URL
  link <- gsub("{{accountId}}", ID, link, fixed = TRUE)

  return(link)
}

getMediaJsonByLocationIDLink <- function(locationID, maxID = ""){

  link <- MEDIA_JSON_BY_LOCATION_ID
  link <- gsub("{{facebookLocationId}}", locationID, link, fixed = TRUE)
  link <- gsub("{{maxId}}", maxID, link, fixed = TRUE)

  return(link)
}

getLocationExploreLink <- function(countryID = "", countrySlug ="", pageID = ""){

  link <- LOCATION_EXPLORE_LINK

  #weird formatting since the backslash cant be there without the country
  if(countryID != ""){
    link <- gsub("{{countryID}}", paste("/",countryID,sep=""), link, fixed = TRUE)
  }
  else{
    link <- gsub("{{countryID}}", countryID, link, fixed = TRUE)
  }

  if(countrySlug != ""){
    link <- gsub("{{countrySlug}}", paste("/",countrySlug,sep=""), link, fixed = TRUE)
  }
  else{
    link <- gsub("{{countrySlug}}", countrySlug, link, fixed = TRUE)
  }

  link <- gsub("{{pageID}}", pageID, link, fixed = TRUE)


  return(link)
}
