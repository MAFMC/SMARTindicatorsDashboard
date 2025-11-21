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
      menuItem("Details", tabName = "details", icon = icon("magnifying-glass-chart"))
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
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      ),
      tabItem("details",
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      )
      
    )
  )
)