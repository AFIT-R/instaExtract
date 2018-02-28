library(ggplot2)

ui <- fluidPage(title = 'My First App!',
                theme = shinythemes::shinytheme('flatly'),



                # Define the sidebar with one input
                sidebarPanel(
                  #category selector
                  selectInput("searchCategory", "Category:",
                              choices=c('Hashtag','Username')),

                  #TEXT INPUT
                  textInput("text", label = h3("Text input"), value = "Enter text..."),

                  #action button
                  actionButton("search", "Search")

                  ),


                # Create a spot for the barplot
                mainPanel(
                )



                )
