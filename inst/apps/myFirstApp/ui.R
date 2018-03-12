
ui <- navbarPage(title = 'InstaExtract',
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
                                       selected = 'Media'),

                           uiOutput("queryCategory") ,

                           uiOutput("getQuery"),

                           uiOutput("getN"),

                           # selectInput("queryCategory", "Category:",
                           #             choices=c('Shortcode','ID', 'LocationID', 'Tag','URL','Username'),
                           #             selected = 'Likes'),
                           #
                           # #TEXT INPUT
                           # textInput("getText", label = h3("Query"), value = "Enter text..."),
                           #
                           # #n input
                           # numericInput("getN", label = h3("Number of Results"), value = '', min = 1),

                           #action button
                           actionButton("get", "Get")

                         ),


                         # Create a spot for the barplot
                         mainPanel(
                           DT::dataTableOutput("get_data_out")
                         )
                )






                )
