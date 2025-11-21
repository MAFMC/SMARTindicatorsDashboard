# user interface definition for dashboard
dashboardPage(
  dashboardHeader(title = "SMART Indicator Summary",
                  titleWidth = 300),
  dashboardSidebar(
    sliderInput("smartThreshold", "Select SMART Threshold",
                min = 0, max = 1, value = 0.5, step = 0.01
    ),
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Category", tabName = "category", icon = icon("object-group")),
      menuItem("Timing", tabName = "timing", icon = icon("calendar")),
      menuItem("Spatial", tabName = "spatial", icon = icon("globe")),
      menuItem("Management", tabName = "management", icon = icon("bars-progress")),
      menuItem("Details", tabName = "details", icon = icon("magnifying-glass-chart")),
      menuItem("About", tabName = "about", icon = icon("glasses"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("dashboard",
              fluidRow(
                valueBoxOutput("ncategories"),
                valueBoxOutput("nindicators"),
                valueBoxOutput("nsmart")
              ),
              fluidRow(
                box(width = 12, status = "primary",
                  uiOutput("getting_started")
                )
              ),
              fluidRow(
                 box(
                   width = 6, status = "info", solidHeader = TRUE,
                   title = "Number of Indicators by Category",
                   plotOutput("catindcount", width = "100%", height = 600)
                 ),
                 box(
                   width = 6, status = "info",
                   title = "Indicator SMART Ratings",
                   dataTableOutput("smarttable")
                 )
               )
      ),
      tabItem("category",
              fluidRow(
                box(
                  selectInput("selectcat", label = h3("Select a Category to Display"), 
                              choices = unique(dummydat$Category), 
                              selected = 1)
                )
              ),
              fluidRow(
                box(
                  width = 12, status = "info", solidHeader = TRUE,
                  title = "SMART Scores by indicator",
                  plotOutput("catfig", width = "100%", height = 600)
                )
              )
      ),
      tabItem("timing",
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      ),
      tabItem("spatial",
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      ),
      tabItem("management",
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      ),
      tabItem("details",
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      ),
      tabItem(tabName = 'about',
              h1("About SMART Indicators", align="center"),
              fluidRow(
                box(width = 9, status = "primary",
                    uiOutput('aboutSMART'),
                ),
                
                box(title = "Development Team",
                    width = 3, status = "primary",
                    
                    p("- Sarah Gaichas"),
                    p("- add names"),
                    br(),
                    p("For more information about the Mid-Atlantic Council please check",
                      "out our website at",
                      a("https://www.mafmc.org/", href = "https://www.mafmc.org/")),
                    br(),
                    p("All code for this project are publically available on",
                      a("GitHub.", href = "https://github.com/MAFMC/SMARTindicatorsDashboard"))
                )
              )
      )
      
    )
  )
)