server <- function(input,output,session){

  output$value <- renderPrint({ input$text })

  observeEvent(input$search,{
    if(input$searchCategory == 'Hashtag'){
      search_results <<- searchTagsByTag(input$text)
    }
    else{
      search_results <<- searchAccountsByUsername(input$text)
    }
  })
}
