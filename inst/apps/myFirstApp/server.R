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
             "Username" = {values$df_get_data <- getMediaByUsername(as.character(input$getQuery), input$getN)},
             "Shortcode" = {values$df_get_data <- getMediaByCode(as.character(input$getQuery))},
             "ID" = {values$df_get_data <- getMediaByID(as.character(input$getQuery))},
             "LocationID" = {values$df_get_data <- getMediaByLocationID(as.character(input$getQuery), input$getN)},
             "Tag" = {values$df_get_data <- getMediaByTag(as.character(input$getQuery), input$getN)},
             "URL" = {values$df_get_data <- getMediaByURL(as.character(input$getQuery))}
      )
      get_results <<- values$df_get_data
    }
    else if(input$getCategory == 'Comments'){
      switch(input$queryCategory,
             "Shortcode" = {values$df_get_data <- getCommentsByMediaCode(as.character(input$getQuery), input$getN)},
             "ID" = {values$df_get_data <- getCommentsByMediaID(as.character(input$getQuery), input$getN)}
      )
      get_results <<- values$df_get_data
    }
    else if(input$getCategory == 'Likes'){
      switch(input$queryCategory,
             "Shortcode" = {values$df_get_data <- getLikesByMediaCode(as.character(input$getQuery), input$getN)},
             "ID" = {values$df_get_data <- getLikesByMediaID(as.character(input$getQuery), input$getN)}
      )
      get_results <<- values$df_get_data
    }
    else if(input$getCategory == 'Location'){
      switch(input$queryCategory,
             "ID" = {values$df_get_data <- getLocationByID(as.character(input$getQuery), input$getN)}
      )
      get_results <<- values$df_get_data
    }
  })

  output$queryCategory <- renderUI({
    if (is.null(input$getCategory))
       return()

    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    switch(input$getCategory,
           "Media" = selectInput("queryCategory", "Query Type:",
                                 choices=c('Shortcode','ID', 'LocationID', 'Tag','URL','Username'),
                                 selected = 'Shortcode'),
           "Comments" = selectInput("queryCategory", "Query Type:",
                                    choices=c('Shortcode','ID'),
                                    selected = 'Shortcode'),
           "Likes" = selectInput("queryCategory", "Query Type:",
                                    choices=c('Shortcode','ID'),
                                    selected = 'Shortcode'),
           "Location" = selectInput("queryCategory", "Query Type:",
                                    choices=c('ID'),
                                    selected = 'ID')
    )
  })

  output$getQuery <- renderUI({
    if (is.null(input$queryCategory))
      return()

    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.

    if(input$getCategory == "Media"){
      switch(input$queryCategory,
             "Shortcode" = textInput("getQuery", "Shortcode",
                                     value = ""),
             "ID" = textInput("getQuery", "ID",
                              value = ""),
             "LocationID" = textInput("getQuery", "LocationID",
                                      value = ""),
             "Tag" = textInput("getQuery", "Hashtag",
                               value = ""),
             "URL" = textInput("getQuery", "URL",
                               value = ""),
             "Username" = textInput("getQuery", "Username",
                                    value = "")
      )
    }
    else if(input$getCategory =="Comments"){
      switch(input$queryCategory,
             "Shortcode" = textInput("getQuery", "Shortcode",
                                     value = ""),
             "ID" = textInput("getQuery", "ID",
                              value = "")
      )
    }
    else if(input$getCategory =="Likes"){
      switch(input$queryCategory,
             "Shortcode" = textInput("getQuery", "Shortcode",
                                     value = ""),
             "ID" = textInput("getQuery", "ID",
                              value = "")
      )
    }
    else if(input$getCategory =="Location"){
      switch(input$queryCategory,
             "ID" = textInput("getQuery", "ID",
                              value = "")
      )
    }

  })

  output$getN <- renderUI({
    if (is.null(input$queryCategory))
      return()

    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    if(input$getCategory == "Media"){

      switch(input$queryCategory,
             "LocationID" = numericInput("getN", label = h3("Number of Results"), value = '12', min = 1),
             "Tag" = numericInput("getN", label = h3("Number of Results"), value = '20', min = 1),
             "Username" = numericInput("getN", label = h3("Number of Results"), value = '12', min = 1)
      )
    }

    else if(input$getCategory =="Comments"){
      numericInput("getN", label = h3("Number of Results"), value = '10', min = 1)
    }
    else if(input$getCategory =="Likes"){
      numericInput("getN", label = h3("Number of Results"), value = '10', min = 1)
    }
  })

  output$search_data_out  <- DT::renderDataTable(values$df_data)
  output$get_data_out  <- DT::renderDataTable(values$df_get_data)
}
