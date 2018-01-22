start_driver <- function(browser = "chrome"){
  if(browser == "IE"){
    cDrv <- wdman::iedriver(port = 4567L)  # creates folder for binaries of server in AppData
    remDr <- RSelenium::remoteDriver(browserName = "IE", port = 4567L) #establishes driver
  }
  else{
    cDrv <- wdman::chrome(port = 4567L)  # creates folder for binaries of server in AppData
    remDr <- RSelenium::remoteDriver(browserName = "chrome", port = 4567L) #establishes driver
  }
}
