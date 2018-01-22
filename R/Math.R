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

  a <- sin(deltaTheta/2) * sin(deltaTheta/2) + cos(theta1) * cos(theta2) *sin(deltaLambda/2)*sin(deltaLambda/2)
  c <- 2* atan2(sqrt(a),sqrt(1-a))
  d <- earth_radius * c

  return(d)

}

degToRad <- function(deg){

  rad <- (deg* pi)/180

  return(rad)
}
