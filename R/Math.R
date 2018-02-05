#'@title Haversine Distance
#'
#'@description Returns the distance between two sets of coordinates in miles
#'
#'@param lat1     Double latitude for first coordinate
#'@param long1    Double longitude for first coordinate
#'@param lat2     Double latitude for second coordinate
#'@param long2    Double longitude for second coordinate
#'
#'@return (Double) miles between two points
#'
#'
#'@examples
#'\dontrun{
#'lat1 <- 38.8977
#'long1 <- 77.0365
#'
#'lat2 <- 40.7484
#'long2 <- 73.9857
#'
#'d <- haversineDistance(lat1, long1, lat2, long2)
#'}
#'
#'@export

haversineDistance <- function(lat1, long1, lat2, long2){

  lat1 <- as.numeric(lat1)
  lat2 <- as.numeric(lat2)
  long1 <- as.numeric(long1)
  long2 <- as.numeric(long2)


  earth_radius <- 3959

  theta1 <- degToRad(lat1)
  theta2 <- degToRad(lat2)
  deltaTheta <- degToRad(lat2 - lat1)
  deltaLambda <- degToRad(long2 - long1)

  a <- sin(deltaTheta/2)^2 + cos(theta1) * cos(theta2) *sin(deltaLambda/2)^2
  c <- 2* atan2(sqrt(a),sqrt(1-a))
  d <- earth_radius * c

  return(d)

}

degToRad <- function(deg){

  rad <- (deg* pi)/180

  return(rad)
}
