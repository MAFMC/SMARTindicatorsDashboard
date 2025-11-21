# calculations to interactively fill dashboard sections

server <- function(input, output) {
  
  dummydat <- data.frame(Indicator = c(LETTERS),
                         Category = c(rep("Economic", 5),
                                      rep("Social", 2),
                                      rep("Fish", 9),
                                      rep("FoodWebBase", 2),
                                      rep("Habitat", 3),
                                      rep("Climate", 5)),
                         SMARTRate = c(runif(26))
  )
  
  output$ncategories <- renderValueBox({
    # count number of categories in the indicator database.
    ncategories <- length(unique(dummydat$Category))

    valueBox(
      value = formatC(ncategories, digits = 0, format = "f"),
      subtitle = "Number of Indicator Categories",
      icon = icon("chart-simple"),
      color =  "aqua"
    )
  })
  
  output$nindicators <- renderValueBox({
    nindicators <- length(unique(dummydat$Indicator))
    
    valueBox(
      value = formatC(nindicators, digits = 0, format = "f"),
      subtitle = "Number of Indicators",
      icon = icon("calculator"),
      color =  "aqua"
    )
  })
    
  output$nsmart <- renderValueBox({
    abovethresh <- dummydat |>
      dplyr::filter(SMARTRate >= input$smartThreshold)
    
    nsmart <- length(abovethresh$SMARTRate)
    nindicators <- length(unique(dummydat$Indicator))

    valueBox(
      value = formatC(nsmart, digits = 0, format = "f"),
      subtitle = "Indicators Meeting Smart Threshold",
      icon = icon("ranking-star"),
      color = if (nsmart <= 0.5*nindicators) "yellow" else "aqua"
    )
  })
  
  output$catindcount <- renderPlot({
    dummydat |>
      dplyr::group_by(Category) |>
      dplyr::summarise(IndCount = n()) |>
      ggplot2::ggplot(ggplot2::aes(x = Category, y=IndCount)) +
      ggplot2::geom_bar(stat = "identity") +
      ggplot2::coord_flip()
  })
 
  output$smarttable <- renderDataTable({
    #dummydat
    DT::datatable(dummydat,
                  options = list(pageLength = nrow(dummydat),
                                 dom = 'tipr')) |>
    DT::formatRound(columns = 'SMARTRate', digits = 2) |>
    DT::formatStyle(
      columns = "SMARTRate", # Column to base the condition on
      target = "row",     # Apply style to the entire row
      backgroundColor = DT::styleInterval(c(input$smartThreshold),
                                          c('white', 'palegreen'))
    )
  })
  
  
}