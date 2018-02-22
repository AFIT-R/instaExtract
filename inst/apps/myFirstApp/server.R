server <- function(input,output,session){

  output$value <- renderPrint({ input$text })

  output$value <- renderPrint({ input$checkGroup })
}
