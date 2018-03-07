server <- function(input,output,session){

  values <- reactiveValues(df_data = NULL)

  output$value <- renderPrint({ input$text })

  observeEvent(input$search,{
    if(input$searchCategory == 'Hashtag'){
      values$df_data <- searchTagsByTag(input$searchText)
      search_results <<- values$df_data
    }
    else{
      values$df_data <- searchAccountsByUsername(input$searchText)
      search_results <<- values$df_data
    }
  })

  observeEvent(input$get,{
    if(input$getCategory == 'Media'){
      switch(input$queryCategory,
             "Username" = {
               values$df_get_data <- getMediaByUsername(as.character(input$getText))
               get_results <<- values$df_get_data
             }
      )
    }
  })
#
#   observe({
#     if(input$getCategory=='Likes'){
#       output$compare <- renderUI({
#         sliderInput("newinput", label = "choices", min = 3, max = 10, value = 5)
#       })
#
#     } else{
#
#       output$compare <- renderUI({
#         selectInput("newinput",
#                     label = "choices", choices = c("Hey", "Hello"), selected = "Hey")
#       })
#     }
#   })

  # output$box <- renderUI({
  #   if (is.null(input$input_type))
  #      return()
  #
  #   # Depending on input$input_type, we'll generate a different
  #   # UI component and send it to the client.
  #   switch(input$input_type,
  #          "slider" = sliderInput("dynamic", "Dynamic",
  #                                 min = 1, max = 20, value = 10),
  #          "text" = textInput("dynamic", "Dynamic",
  #                             value = "starting value")
  #   )
  # })
  # outputOptions(output, "box", suspendWhenHidden = FALSE)

  output$search_data_out  <- DT::renderDataTable(values$df_data)
  output$get_data_out  <- DT::renderDataTable(values$df_get_data)
}
