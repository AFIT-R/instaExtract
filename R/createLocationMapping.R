#'@title Create Location Mapping
#'
#'@description Creates a dataframe listing all locations in a specified scope
#'
#'@param country  Country name/s for creation scope
#'@param city     City name/s for creation scope
#'@param lat_long True - retrieve coordinates, False - No coordinates
#'@param ...    Additional options passed to a shinyAppDir
#'
#'@return n x 11 DF where n is the number of locations in the scope: id, name, slug, city_ID, \cr
#'city_Name, city_slug, country_ID, country_Name, country_Slug, latitude, longitude
#'
#'
#'@examples
#'\dontrun{ createLocationMapping("United States", "New York", True)}
#'
#'@export

#create a mapping for instagram posts, to search for posts in a certain range
#from a lat long


# Create Location Mappingg
#
# returns the TOP media for a given location ID
#
#INPUTS:
# locationID - location Id used by facebook
#
#OUTPUTS:
#
# n x 11 DF where n is the number of locations in the scope: id, name, slug, city_ID, city_Name, city_slug,
#country_ID, country_Name, country_Slug, latitude, longitude

createLocationMapping <- function(country ="", city = "", lat_long = FALSE){



  #-------------------------------
  #----COUNTRY SEARCH-------------
  #-------------------------------

  if(country[1] != ""){
    country_search <- data.frame()
    for(row in 1:length(country)){
      country_search[row, 1] <- country[row]
      country_search[row,2] <- FALSE
    }
  }


  page <- ""
  more_available <- TRUE
  country_found <- FALSE
  country_data <- data.frame()

  while(!country_found && more_available){

    #get the link for the generic location explore hub
    url <- getLocationExploreLink(pageID = page)

    #get the data from the link
    #will return the first page of countries
    response <- getJSONFromURL(url)

    #flattening the data down to the nodes, into a dataframe
    response_data <- jsonlite::flatten(response$country_list)

    #for every country on the current page
    for(row in 1:nrow(response_data)){

      #if mapping all countries, add all information to the country data
      if(country[1] == ""){
        country_data <- rbind(country_data,response_data[row,])
      }
      #check if the country name matches what we are searching for

      else{
        for(country_number in 1:nrow(country_search)){
          if(response_data[row,2] == country_search[country_number,1]){
            country_search[country_number,2] <- TRUE
            country_data <- rbind(country_data,response_data[row,])
          }
        }
      }

    }

    #if there is a next page
    if( !is.null(response$next_page)){
      page = response$next_page
    }
    else{
      more_available = FALSE
    }

    if(nrow(country_data) == nrow(country_search)){
      country_found <- TRUE
    }

  }

  #if the country could not be found when not cataloguing all countries
  if(!more_available && !country_found && country != ""){
    stop("Could not find country")

  }

  #-------------------------------
  #----CITY SEARCH-------------
  #-------------------------------


  if(city[1] != ""){
    city_search <- data.frame()
    for(row in 1:length(city)){
      city_search[row, 1] <- city[row]
      city_search[row,2] <- FALSE
    }
  }

  city_data <- data.frame()
  city_found <- FALSE

  for(row in 1:nrow(country_data)){

    print(paste(row," / ", nrow(country_data), " countries", sep = ""))
    print(country_data[row,2])


    page <- ""
    more_available <- TRUE

    # city_data[, "country_ID"] <- NA
    # city_data[, "country_Name"] <- NA
    # city_data[, "country_Slug"] <- NA


    while(!city_found && more_available){

      #get the link for the generic location explore hub
      url <- getLocationExploreLink(countryID = country_data[row,1], countrySlug = country_data [row,3], pageID = page)

      #get the data from the link
      #will return the first page of countries
      response <- getJSONFromURL(url)


      if(length(response$city_list) == 0){
        more_available = FALSE
      }
      else{
        #flattening the data down to the nodes, into a dataframe
        response_data <- jsonlite::flatten(response$city_list)

        #for every country on the current page
        for(subrow in 1:nrow(response_data)){

          #if mapping all countries, add all information to the country data
          if(city[1] == ""){
            city_data <- plyr::rbind.fill(city_data,response_data[subrow,])

            city_data[nrow(city_data), "country_ID"] <- country_data[row,1]
            city_data[nrow(city_data), "country_Name"] <- country_data[row,2]
            city_data[nrow(city_data), "country_Slug"] <- country_data[row,3]
          }
          #check if the country name matches what we are searching for
          else{
            for(city_number in 1:nrow(city_search)){
              if(response_data[subrow,2] == city_search[city_number,1]){
                city_search[city_number,2] <- TRUE

                city_data <- plyr::rbind.fill(city_data,response_data[subrow,])

                city_data[nrow(city_data), "country_ID"] <- country_data[row,1]
                city_data[nrow(city_data), "country_Name"] <- country_data[row,2]
                city_data[nrow(city_data), "country_Slug"] <- country_data[row,3]
              }
            }
          }

        }#end nested for loop

        #if there is a next page
        if( !is.null(response$next_page)){
          page = response$next_page
        }
        else{
          more_available = FALSE
        }

        if(nrow(city_data) == nrow(city_search)){
          city_found <- TRUE
        }
      }#end else

    }#end while loop


  } #end for loop

  #-------------------------------
  #----LOCATION SEARCH-------------
  #-------------------------------


  location_data <- data.frame()

  for(row in 1:nrow(city_data)){

    print(paste(row," / ", nrow(city_data), " cities", sep = ""))
    print(city_data[row,2])


    page <- ""
    more_available <- TRUE

    # city_data[, "country_ID"] <- NA
    # city_data[, "country_Name"] <- NA
    # city_data[, "country_Slug"] <- NA


    while(more_available){

      #get the link for the generic location explore hub
      url <- getLocationExploreLink(countryID = city_data[row,1], countrySlug = city_data [row,3], pageID = page)

      #get the data from the link
      #will return the first page of countries
      response <- getJSONFromURL(url)

      if(length(response$location_list) == 0){
        more_available = FALSE
      }
      else{
        #flattening the data down to the nodes, into a dataframe
        response_data <- jsonlite::flatten(response$location_list)

        #for every country on the current page
        for(subrow in 1:nrow(response_data)){
#
#           print(paste(subrow," / ", nrow(response_data), " locations", sep = ""))
#           print(response_data[subrow,2])

          location_data <- plyr::rbind.fill(location_data,response_data[subrow,])
          location_data[nrow(location_data), "city_ID"] <- city_data[row,1]
          location_data[nrow(location_data), "city_Name"] <- city_data[row,2]
          location_data[nrow(location_data), "city_Slug"] <- city_data[row,3]
          location_data[nrow(location_data), "country_ID"] <- city_data[row,4]
          location_data[nrow(location_data), "country_Name"] <- city_data[row,5]
          location_data[nrow(location_data), "country_Slug"] <- city_data[row,6]

        }#end nested for loop

        #if there is a next page
        if( !is.null(response$next_page)){
          page = response$next_page
        }
        else{
          more_available = FALSE
        }
      }#end else

    }#end while loop

  } #end for loop

  if(!lat_long){

    #adding coloumns for consistency
    location_data[, "latitude"] <- NA
    location_data[, "longitude"] <- NA

    return(location_data)
  }

  #-------------------------------
  #----LAT LONG GENERATION--------
  #-------------------------------

  print(paste("Total Locations: ",nrow(location_data), sep = ""))
  percent <- 0
  time <- Sys.time()



  for(row in 1:nrow(location_data)){

    if(row/nrow(location_data) > percent+.025){
      print(paste("Progress: ",round(percent * 100,2), "%", sep = ""))
      percent <- row/nrow(location_data)

      print(paste("Est Time Left: ",round((Sys.time() - time)*(100 - percent*100),4), "seconds", sep = ""))
      time <- Sys.time()
    }

    location_url <- getLocationExploreLink(countryID = location_data[row,1], countrySlug = location_data[row,3])
    location_response <- getJSONFromURL(url)

    if(!is.null( location_response$location$lat)){

      location_data[row, "latitude"] <- location_response$location$lat
    }
    if(!is.null(location_response$location$lng)){

      location_data[row, "longitude"] <- location_response$location$lng
    }

  }#end lat long for loop



  return(location_data)

}
