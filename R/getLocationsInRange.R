getLocationsInRange <- function(data, r, lat, long){

  if(!is.numeric(r) || !is.numeric(lat) || !is.numeric(long)){
    stop("r, lat, and long, must be numeric")
  }

  data <- filter(data, haversineDistance(latitude, longitude, lat, long) <= r)

  return(data)
}
