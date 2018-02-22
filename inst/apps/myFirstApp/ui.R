ui <- fluidPage(title = 'My First App!',
                theme = shinythemes::shinytheme('flatly'),

                #TEXT INPUT
                textInput("text", label = h3("Text input"), value = "Enter text..."),

                hr(),
                fluidRow(column(3, verbatimTextOutput("value"))),


                #SEARCH SELECTION
                checkboxGroupInput("checkGroup", label = h3("Checkbox group"),
                                   choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                                   selected = 1),


                hr(),
                fluidRow(column(3, verbatimTextOutput("value")))


                )
