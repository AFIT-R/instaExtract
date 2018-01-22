# Get Alternative Text
#
# this function returns the alt image text (also the caption of the image)
# from the first n images on instagram's eplore site
#
#INPUTS:
# tag - string that will be searched on instagram
# n - number of images to look at
#
#OUTPUTS:
#
# img_text - string array with text from alts of images


get_alt_text <- function(tag, n = 20){
  tag <- tag
  tag_url_base <- "https://www.instagram.com/explore/tags/"
  url <- paste(tag_url_base,tag,"/",sep = "")

  image_node <- "._2di5p"  # the css node for the images on a explore site

  cDrv <- wdman::chrome(port = 4567L)  # creates folder for binaries of server in AppData
  remDr <- RSelenium::remoteDriver(browserName = "chrome", port = 4567L) #establishes driver


  ## Open the browser webpage
  remDr <- RSelenium::remoteDriver(browserName = "chrome", port = 4567L) #establishes driver
  remDr$open()

  #navigate to the url in the browser
  remDr$navigate(url)

  #save the info loaded
  page_source<- remDr$getPageSource()

  #extract the alt text attribute from the image nodes
  img_text <- xml2::read_html(page_source[[1]]) %>% rvest::html_nodes(image_node) %>%
    rvest::html_attr("alt")

  remDr$close() #close driver
  cDrv$stop()

  return(img_text)
}
