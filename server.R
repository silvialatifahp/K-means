library(shiny)
library(shinydashboard)

shinyServer(
  function(input, output, session) {
    #DATAUJI
    ujikmeans <- reactive({
      input$data_uji
    })
    #KETERANGAN KMEANS
    output$tablekmeans <- renderDataTable({
      req(ujikmeans())
      uji <- read_xlsx(ujikmeans()$datapath)
      datatable(uji, options = list (scrollx=TRUE))
    })
    
    #PLOT
    dvalidkm <- reactive({
      input$data_valid
    })
    output$tablevalidkm <- renderDataTable({
      req(dvalidkm())
      valid <- read_xlsx(dvalidkm()$datapath)
      datatable()
    })
    
    #P
    selectedData <- reactive({
      ujikmeans()[, c(input$var1, input$var2)]
    })
    clusters <- reactive({
      kmeans(selectedData(), input$clusters)
    })
    
    output$plot1 <- renderPlot({
      palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
      par(mar = c(5.1, 4.1, 0, 1))
      plot(selectedData(),
           col = clusters()$cluster,
           pch = 20, cex = 1)
      points(cluster()$centers, pch=4, cex = 1, lwd = 3)
    })
  } #function
) #shinyserver
