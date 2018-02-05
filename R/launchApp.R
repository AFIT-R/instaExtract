#'@title Launch App
#'
#'@description Launches the Shiny App for the instaExtract Package
#'
#'@param dir   A file directory for the app
#'@param ...   Additional options passed to a shinyAppDir
#'
#'@return N/A
#'
#'@examples
#'\dontrun{ launchApp()}
#'
#'@export

launchApp <- function(dir,..){

  app_dir <- system.file('apps', 'myFirstApp', package = 'instaExtract')

  shiny::shinyAppDir(app_dir)

}
