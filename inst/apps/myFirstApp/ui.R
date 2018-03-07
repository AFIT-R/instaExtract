# ui <- fluidPage(title = 'My First App!',
#                 theme = shinythemes::shinytheme('flatly'),
#
#                 sidebarPanel(
#                   htmlOutput('compare'),
#                   #category selector
#                   selectInput("getCategory", "Category:",
#                               choices=c('Media','Comments', 'Likes', 'Location'),
#                               selected = 'Likes'),
#
#                   #TEXT INPUT
#                   textInput("geText", label = h3("Text input"), value = "Enter text..."),
#
#
#
#                   selectInput("input_type", "Input type",
#                               c("slider", "text")
#                   ),
#
#                   uiOutput("box"),
#
#                   #action button
#                   actionButton("get", "Get")
#
#
#
#                 ),
#
#
#                 # Create a spot for the barplot
#                 mainPanel(
#                   DT::dataTableOutput("df_data_out")
#                 )
#
#                 )

ui <- navbarPage(title = 'My First App!',
                theme = shinythemes::shinytheme('flatly'),

                tabPanel('Search',
                         # Define the sidebar with one input
                         sidebarPanel(
                           #category selector
                           selectInput("searchCategory", "Category:",
                                       choices=c('Hashtag','Username')),

                           #TEXT INPUT
                           textInput("searchText", label = h3("Text input"), value = "Enter text..."),

                           #action button
                           actionButton("search", "Search")

                         ),


                         # Create a spot for the barplot
                         mainPanel(
                           DT::dataTableOutput("search_data_out")
                         )
                 ),

                tabPanel('Get',
                         # Define the sidebar with one input
                         sidebarPanel(

                           #category selector
                           selectInput("getCategory", "Category:",
                                       choices=c('Media','Comments', 'Likes', 'Location'),
                                       selected = 'Likes'),

                           selectInput("queryCategory", "Category:",
                                       choices=c('Shortcode','ID', 'LocationID', 'Tag','URL','Username'),
                                       selected = 'Likes'),

                           #TEXT INPUT
                           textInput("getText", label = h3("Query"), value = "Enter text..."),

                           #n input
                           numericInput("getN", label = h3("Number of Results"), value = '', min = 1),



                           selectInput("input_type", "Input type",
                                         c("slider", "text")
                             ),

                           uiOutput("box"),

                           #action button
                           actionButton("get", "Get")

                         ),


                         # Create a spot for the barplot
                         mainPanel(
                           DT::dataTableOutput("get_data_out")
                         )
                )






                )
