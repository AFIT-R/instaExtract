
#create a mapping for instagram posts, to search for posts in a certain range
#from a lat long

createLocationMapping <- function(country ="", city = "", all = FALSE){



  #-------------------------------
  #----COUNTRY SEARCH-------------
  #-------------------------------

  page <- ""
  more_available <- TRUE
  country_found <- FALSE
  country_data <- data.frame()

  while((all || !country_found) && more_available){

    #get the link for the generic location explore hub
    url <- getLocationExploreLink(pageID = page)

    #get the data from the link
    #will return the first page of countries
    response <- jsonlite::fromJSON(url)

    #flattening the data down to the nodes, into a dataframe
    response_data <- jsonlite::flatten(response$country_list)

    #for every country on the current page
    for(row in 1:nrow(response_data)){

      #if mapping all countries, add all information to the country data
      if(country == ""){
        country_data <- rbind(country_data,response_data[row,])
      }
      #check if the country name matches what we are searching for
      if(response_data[row,2] == country){
        country_found <- TRUE
        country_row <- row
      }
    }

    #if there is a next page
    if( !is.null(response$next_page)){
      page = response$next_page
    }
    else{
      more_available = FALSE
    }

  }

  #if the country could not be found when not cataloguing all countries
  if(!more_available && !country_found && country != ""){
    stop("Could not find country")

  }

  if(country_found){
    country_data <- response_data[country_row,]
  }


  #-------------------------------
  #----CITY SEARCH-------------
  #-------------------------------

  for(row in 1:nrow(country_data)){

    print(paste(row," / ", nrow(country_data), sep = ""))
    print(country_data[row,2])


    page <- ""
    more_available <- TRUE
    city_found <- FALSE
    city_data <- data.frame()

    # city_data[, "country_ID"] <- NA
    # city_data[, "country_Name"] <- NA
    # city_data[, "country_Slug"] <- NA


    while((all || !city_found) && more_available){

      #get the link for the generic location explore hub
      url <- getLocationExploreLink(countryID = country_data[row,1], countrySlug = country_data [row,3], pageID = page)

      #get the data from the link
      #will return the first page of countries
      response <- jsonlite::fromJSON(url)


      if(length(response$city_list) == 0){
        more_available = FALSE
      }
      else{
        #flattening the data down to the nodes, into a dataframe
        response_data <- jsonlite::flatten(response$city_list)

        #for every country on the current page
        for(subrow in 1:nrow(response_data)){

          #if mapping all countries, add all information to the country data
          if(city == ""){
            city_data <- plyr::rbind.fill(city_data,response_data[subrow,])

            city_data[subrow, "country_ID"] <- country_data[row,1]
            city_data[subrow, "country_Name"] <- country_data[row,2]
            city_data[subrow, "country_Slug"] <- country_data[row,3]
          }
          #check if the country name matches what we are searching for
          if(response_data[subrow,2] == city){
            city_found <- TRUE
            city_row <- subrow
          }
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

  #if the country could not be found when not cataloguing all countries
  if(!more_available && !city_found && !all && city != ""){
    stop("Could not find city")

  }

  if(city_found){
    city_data <- response_data[city_row,]
  }


  return(city_data)

}
