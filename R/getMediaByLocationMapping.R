getMediaByLocationMapping <- function(mapping, n = 12){

  full_data <- data.frame()

  print(paste("Total Locations: ", nrow(mapping)))
  percent <- 0
  time <- Sys.time()

  for(row in 1:nrow(mapping)){


    if(row/nrow(mapping) > percent+.01){

      percent <- row/nrow(mapping)
      print(paste("Progress: ",percent * 100, "%", sep = ""))

      print(paste("Est Time Left: ",(Sys.time() - time)*(100 - percent*100), "seconds", sep = ""))
      time <- Sys.time()
    }

    location_media <- getMediaByLocationID(mapping[row,1], n)

    if(!is.null(location_media)){

      full_data <- plyr::rbind.fill(full_data, location_media )

    }
  }

  return(full_data)

}
