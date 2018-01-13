getIDFromCode <- function(code){
  alphabet <- "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
  ID <- 0
  for(i in 1:nchar(code)){
    c <- substr(code,i,i)
    id <- id * 64+ regexpr(c, alphabet)[1]
  }

  return(ID)
}


getCodeFromID <- function(ID){
  alphabet <- "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
  code <- ""
  ID <- bit64::as.integer64.character(ID)

  while(ID >0){

    remainder <- ID %% bit64::as.integer64.double(64)
    ID <- (ID - remainder) %/% 64
    code <- paste(substr(alphabet,remainder+1,remainder+1),code,sep="")
  }

  return(code)

}

getLinkFromID <- function(ID){

  return(
    getCodeFromID(ID) %>%
      getMediaPageLink()
    )
}

