# calculations to interactively fill dashboard sections

server <- function(input, output) {
  
  # put data in the global section so UI can use it too
  # dummydat <- data.frame(Indicator = c(LETTERS),
  #                        Category = c(rep("Economic", 5),
  #                                     rep("Social", 2),
  #                                     rep("Fish", 9),
  #                                     rep("FoodWebBase", 2),
  #                                     rep("Habitat", 3),
  #                                     rep("Climate", 5)),
  #                        SMARTRate = c(runif(26))
  # )
  
# dashboard
  
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
      dplyr::summarise(IndCount = n(),
                       SMARTInds = sum(SMARTRate > input$smartThreshold)) |>
      tidyr::pivot_longer(-Category, names_to = "SMART", values_to = "NumberInds") |>
      ggplot2::ggplot(ggplot2::aes(x = Category, y=NumberInds, fill=SMART)) +
      ggplot2::geom_bar(position="identity", stat = "identity") +
      ggplot2::coord_flip() +
      ggplot2::scale_fill_manual(values = c("SMARTInds" = 'palegreen', "IndCount" = "grey"))
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
  
# category statistics
  
  output$catfig <- renderPlot({
    dummydat |>
      dplyr::filter(Category == input$selectcat) |>
      ggplot2::ggplot(ggplot2::aes(x=Indicator, y=SMARTRate)) +
      ggplot2::geom_bar(stat = "identity") +
      ggplot2::geom_hline(yintercept = input$smartThreshold, colour='palegreen') +
      ggplot2::ggtitle(paste(input$selectcat))
  })
  
  # output$catts <-  renderPlot({
  #   dummydat |>
  #     dplyr::filter(Category == input$selectcat) |>
  #     ggplot2::ggplot(ggplot2::aes(x=Indicator, y))
  # 
  # })
  
# select time frame or area to id indicators
  
  
# later: select decision or decision type  
  
  
# links to detailed pages by indicator  
  
# rendered pages
  output$aboutSMART <- renderUI({
    withMathJax({
      k = knitr::knit(input = "AboutSMART.Rmd", quiet = T)
      HTML(markdown::markdownToHTML(k, fragment.only = T))
    })
  })
  
  output$getting_started <- renderUI({
    withMathJax({
      k = knitr::knit(input = "GettingStarted.Rmd", quiet = T)
      HTML(markdown::markdownToHTML(k, fragment.only = T))
    })
  })
  
}