

###############################
#####  JSON LINKS #############
###############################

User_Media_Json_Link <- "https://www.instagram.com/{username}/?__a=1&max_id={maxID}"
Tag_Media_Json_Link <- "https://www.instagram.com/explore/tags/{tag}/?__a=1&max_id={maxID}"
Search_Json_Link <- "https://www.instagram.com/web/search/topsearch/?query={query}"







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
