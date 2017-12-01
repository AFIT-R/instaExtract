getIDFromCode <- function(code){
  alphabet <- "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
  id <- 0
  for(i in 1:nchar(code)){
    c <- substr(code,i,i)
    id <- id * 64+ regexpr(c, alphabet)[1]
  }

  return(id)
}


getCodeFromID <- function(ID){
  alphabet <- "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
  code <- ""
  while(id > 0){
    remainder <- id %% 64
    id <- (id - remainder) / 64
    code <- paste(substr(alphabet,remainder,remainder),code,sep="")
  }

  return(code)

}
